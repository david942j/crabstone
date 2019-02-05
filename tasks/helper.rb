# frozen_string_literal: true

require 'English'

# Only for tasks/*.rake to use.
# @private
module Helper
  module_function

  def module_name(arch)
    # it's hard to change arch into the camel-case module name,
    # so we simply use upcase and fixup some cases.
    case arch
    when 'sparc' then 'Sparc'
    when 'systemz', 'sysz' then 'SysZ'
    when 'xcore' then 'XCore'
    else arch.upcase
    end
  end

  def glob(pattern, &block)
    Dir.glob(File.join(@cs_path, pattern), &block)
  end

  def write_dotversion
    File.open(File.join(@target_dir, '.version'), 'w') do |f|
      f.puts @version
    end
  end

  # Convert python/capstone/<arch>.py to arch/<version>/<arch>.rb
  class Python
    attr_reader :arch

    def initialize(file)
      @file = file
      @arch = module_name(@file).downcase
    end

    # Use an extra python script to read those structs out and print them in normalized form to have the parsing
    # procedure much easier.
    def to_layout
      res = `#{File.join(__dir__, 'print_structs.py')} #{@file}`
      raise 'Unexpected error in python script' unless $CHILD_STATUS.exitstatus.zero?

      res.lines.each_with_object([]) do |line, ret|
        if line.start_with?('class ')
          ret << to_ruby_class(line.slice(6..-1)) << '  layout('
        elsif line.strip.empty?
          ret << '  )' << "end\n"
        else
          ret << '    ' + to_field(line) + ','
        end
      end
    end

    private

    # Convert 'SyszOpValue:UnionType' to 'OperantValue < FFI::Union'
    # Only for {.py_to_layout} to use.
    def to_ruby_class(py_class)
      klass_name, ffi_type = py_class.strip.split(':')
      ffi_type = {
        'UnionType' => 'FFI::Union',
        'PyCStructType' => 'FFI::Struct'
      }[ffi_type] || raise("Unsupported type: #{py_class.inspect}")

      "class #{normalize_class_name(klass_name)} < #{ffi_type}"
    end

    def normalize_class_name(py_class)
      if py_class.start_with?('Cs')
        'Instruction'
      else
        raise "Unexpcted class name: #{py_class.inspect}" unless py_class.downcase.start_with?(arch.downcase)

        py_class[arch.size..-1].sub('Op', 'Operand').sub('Mem', 'Memory')
      end
    end

    # operands, SyszOp, 6
    # => :operands, [Operand, 6]
    #
    # op_count, c_ubyte
    # => :op_count, :uint8
    def to_field(line)
      tokens = line.strip.split(',').map(&:strip)
      raise "Unexpected error: #{line.inspect}" unless tokens.size.between?(2, 3)

      name = tokens.shift
      type = if tokens.size == 1
               cpy_to_sym(tokens.first)
             else # Array
               "[#{cpy_to_sym(tokens.first)}, #{tokens.last}]"
             end
      "#{name.to_sym.inspect}, #{type}"
    end

    def cpy_to_sym(str)
      return normalize_class_name(str) unless str.start_with?('c_')

      str = str[2..-1]
      case str
      when 'uint', 'int', 'ulong', 'long', 'bool', 'float', 'ushort', 'short', 'double' then str.to_sym
      when 'ubyte' then :uint8
      when 'byte' then :int8
      else raise "QQ: #{str.inspect}"
      end.inspect
    end
  end

  class HParser
    attr_accessor :include_path, :file
    attr_reader :code

    def initialize
      @include_path = []
      @file = nil
      yield self if block_given?
      preprocess!
    end

    def fetch_struct(type)
      # Well..
      no = @code.find_index { |l| l.index(/typedef\s+struct\s+#{type}\s*{/) }
      data = match_brackets do
        no += 1 while @code[no].strip.empty?
        @code[no].strip.gsub(/\s+/, ' ').tap { no += 1 }
      end
      expect(data.first, "typedef struct #{type} {")
      expect(data.last, "} #{type};")
      temp = []
      data[1..-2].each_with_object(Struct.new) do |line, struct|
        next if line.include?('{') || line.include?('}')

        temp << line
        next unless temp.last.strip.end_with?(';')

        struct << Field.parse(temp.join(' '))
        temp = []
      end
    end

    private

    def expect(data, to_be)
      return if data == to_be

      raise "Expected: #{to_be.inspect}, got: #{data.inspect}"
    end

    # Only matches curly brackets since we are parsing struct.
    # @yieldreturn [String]
    # @return [Array<String>]
    def match_brackets
      data = []
      @count = 0
      loop do
        data << yield.tap do |s|
          s.each_char do |c|
            if c == '{' then @count += 1
            elsif c == '}' then @count -= 1
            end
          end
        end
        break if @count.zero?
      end
      data
    end

    def preprocess!
      return if defined?(@code)

      # This is for developer to use, I don't care cmd injection or somewhat
      @code = `cpp #{@include_path.map { |p| '-I' + p }.join(' ')} #{@file}`
      @code = @code.lines.reject { |l| l.start_with?('#') }
    end

    class Struct
      attr_reader :fields

      def initialize
        @fields = []
      end

      def <<(field)
        @fields << field
      end

      def to_layout
        <<~LAYOUT
          layout(
            #{@fields.map(&:to_layout).join(",\n  ")}
          )
        LAYOUT
      end
    end

    class Field
      class << self
        def parse(str)
          tokens = str.split(' ')
          var = tokens.pop
          tokens << var.slice!(0..var.rindex('*')) if var.start_with?('*')
          var = parse_var(var)
          type, ref_c, type_s = parse_type(tokens.join(' '))
          new(var, type || type_s.to_sym, ref_c)
        end

        private

        # @return [(String, Integer)]
        #   (name, nmemb)
        def parse_var(str)
          data = str.match(/^([\w_]+)(\[(\d+)\])?;$/)
          raise "Unexpected var name: #{str.inspect}" if data.nil?

          [data[1], (data[3] || 1).to_i]
        end

        def parse_type(str)
          ref_c = str.count('*')
          str = str.delete('*').strip
          type = to_type(str)
          [type, ref_c, str]
        end

        def to_type(str)
          case str
          when /^uint(8|16|32|64)_t$/ then str[0..-3].to_sym
          when 'unsigned int' then :uint32
          when 'char' then str.to_sym
          end
        end
      end

      attr_reader :name, :type

      def initialize(var, type, ref_c)
        @name, @nmemb = var
        @type = type
        @ref_c = ref_c
      end

      # cs_detail *d # :d, Detail.by_ref
      # int *d # :d, :pointer
      # int d # :d, :int
      # int d[10] # :d, [:int, 10]
      # int* d[10] # :d, [:pointer, 10]
      def to_layout
        # cs_detail *detail
        if @type == :cs_detail
          raise 'Only support cs_detail*' unless @ref_c == 1 && @nmemb == 1

          return ":#{name}, Detail.by_ref"
        end
        type = @ref_c.zero? ? @type : :pointer
        return ":#{name}, [:#{type}, #{@nmemb}]" if @nmemb > 1

        ":#{name}, :#{type}"
      end
    end
  end
end
