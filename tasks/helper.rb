# frozen_string_literal: true

# @private
module Helper
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
      no = @code.find_index { |l| l.index(/typedef\s+struct\s+#{type}/) }
      data = match_brackets do
        no += 1 while @code[no].strip.empty?
        @code[no].strip.gsub(/\s+/, ' ').tap { no += 1 }
      end
      expect(data.first, "typedef struct #{type} {")
      expect(data.last, "} #{type};")
      data[1..-2].each_with_object(Struct.new) do |line, struct|
        # TODO: fetch union
        next if line.include?('{') || line.include?('}')

        struct << Field.parse(line)
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

      attr_reader :name

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
