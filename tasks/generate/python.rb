# frozen_string_literal: true

require 'English'

require_relative 'helper'

module Generate
  # Convert python/capstone/<arch>.py to arch/<version>/<arch>.rb
  class Python
    attr_reader :arch

    def initialize(path_to_cs_py_binding, file)
      @path_to_py = path_to_cs_py_binding
      @file = file
      @arch = Helper.module_name(@file).downcase
    end

    # Use an extra python script to read those structs out and print them in normalized form to have the parsing
    # procedure much easier.
    def to_layout
      res = `#{File.join(__dir__, 'print_structs.py')} '#{@path_to_py}' '#{@file}'`
      raise 'Unexpected error in python script' unless $CHILD_STATUS.exitstatus.zero?

      first = true
      res.lines.each_with_object([]) do |line, ret|
        if line.start_with?('class ')
          ret << '' unless first
          first = false
          ret << to_ruby_class(line.slice(6..-1)) << '  layout('
        elsif line.strip.empty?
          ret.last.slice!(-1) if ret.last.end_with?(',')
          ret << '  )' << 'end'
        else
          ret << +"    #{to_field(line)},"
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
        return 'Encoding' if py_class.end_with?('Encoding')

        'Instruction'
      else
        raise "Unexpcted class name: #{py_class.inspect}" unless py_class.downcase.start_with?(arch.downcase)

        py_class[arch.size..].sub('Op', 'Operand').sub('Mem', 'Memory')
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

      str = str[2..]
      case str
      when 'uint', 'int', 'ulong', 'long', 'bool', 'float', 'ushort', 'short', 'double' then str.to_sym
      when 'ubyte' then :uint8
      when 'byte' then :int8
      else raise "QQ: #{str.inspect}"
      end.inspect
    end
  end
end
