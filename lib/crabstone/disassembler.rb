# frozen_string_literal: true

require 'ffi'

require 'crabstone/binding'
require 'crabstone/error'
require 'crabstone/instruction'
require 'crabstone/version'

module Crabstone
  class Disassembler
    SYNTAX = {
      intel: 1,
      att: 2,
      no_regname: 3 # for PPC only
    }.freeze

    DETAIL = {
      true => 3, # trololol
      false => 0
    }.freeze

    SKIPDATA = {
      true => 3, # trololol
      false => 0
    }.freeze

    attr_reader :arch, :mode, :csh, :syntax, :decomposer

    def initialize(arch, mode)
      maj, min = version
      raise "FATAL: Crabstone v#{VERSION} doesn't support binding Capstone v#{maj}.#{min}" if maj > BINDING_MAJ

      @arch = arch
      @mode = mode
      p_size_t = FFI::MemoryPointer.new(:ulong_long)
      @p_csh = FFI::MemoryPointer.new(p_size_t)
      safe { Binding.cs_open(arch, mode, @p_csh) }

      @csh = @p_csh.read_ulong_long
    end

    # After you close the engine, don't use it anymore. Can't believe I even
    # have to write this.
    #
    # @return [void]
    def close
      safe { Binding.cs_close(@p_csh) }
    end

    def syntax=(new_stx)
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrOption]) unless SYNTAX[new_stx]
      set_raw_option(OPT_SYNTAX, SYNTAX[new_stx])
      @syntax = new_stx
    end

    # @param [Boolean] new_val
    def decomposer=(new_val)
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrOption]) unless DETAIL[new_val]
      set_raw_option(OPT_DETAIL, DETAIL[new_val])
      @decomposer = new_val
    end

    def version
      maj = FFI::MemoryPointer.new(:int)
      min = FFI::MemoryPointer.new(:int)
      Binding.cs_version(maj, min)
      [maj.read_int, min.read_int]
    end

    def diet?
      DIET_MODE
    end

    def errno
      Binding.cs_errno(@csh)
    end

    def skipdata(mnemonic = '.byte')
      cfg = Binding::SkipdataConfig.new
      cfg[:mnemonic] = FFI::MemoryPointer.from_string(mnemonic.to_s)

      if block_given?
        cfg[:callback] = FFI::Function.new(
          :size_t,
          %i[pointer size_t size_t pointer]
        ) do |code, sz, offset, _|
          code = code.read_array_of_uchar(sz).pack('c*')
          begin
            Integer(yield(code, offset))
          rescue StandardError
            warn "Error in skipdata callback: #{$ERROR_INFO}"
            # It will go on to crash, but now at least there's more info :)
          end
        end
      end

      set_raw_option(OPT_SKIPDATA_SETUP, cfg.pointer.address)
      set_raw_option(OPT_SKIPDATA, SKIPDATA[true])
    end

    def skipdata_off
      set_raw_option(OPT_SKIPDATA, SKIPDATA[false])
    end

    def reg_name(regid)
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrDiet]) if DIET_MODE
      name = Binding.cs_reg_name(csh, regid)
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrCsh]) unless name
      name
    end

    # @return [Array<Crabstone::Instruction>]
    def disasm(code, offset, count = 0)
      return [] if code.empty?

      insn_ptr   = FFI::MemoryPointer.new(:pointer)
      insn_count = Binding.cs_disasm(
        @csh,
        code,
        code.bytesize,
        offset,
        count,
        insn_ptr
      )
      Crabstone.raise_errno(errno) if insn_count.zero?

      convert_disasm_result(insn_ptr, insn_count).tap { Binding.free(insn_ptr.read_pointer) }
    end

    def set_raw_option(opt, val)
      safe { Binding.cs_option(csh, opt, val) }
    end

    private

    # Convert the insn_ptr from cs_disasm into Ruby instruction objects.
    # @param [FFI::MemoryPointer] insn_ptr
    # @param [Integer] insn_count
    # @return [Array<Crabstone::Instruction>]
    def convert_disasm_result(insn_ptr, insn_count)
      insn_sz = Binding::Instruction.size
      Array.new(insn_count) do |i|
        cs_insn_ptr = Binding.malloc(insn_sz)
        Binding.memcpy(cs_insn_ptr, insn_ptr.read_pointer + i * insn_sz, insn_sz)
        Crabstone::Instruction.new(@csh, Binding::Instruction.new(cs_insn_ptr), @arch)
      end
    end

    def safe
      yield.tap { |res| Crabstone.raise_errno(res) unless res.zero? }
    end
  end
end
