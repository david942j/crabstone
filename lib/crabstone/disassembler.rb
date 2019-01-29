require 'crabstone/binding'
require 'crabstone/instruction'

module Crabstone
  class Disassembler

    attr_reader :arch, :mode, :csh, :syntax, :decomposer

    def initialize arch, mode

      maj, min = version
      if maj != BINDING_MAJ || min != BINDING_MIN
        raise "FATAL: Binding for #{BINDING_MAJ}.#{BINDING_MIN}, found #{maj}.#{min}"
      end

      @arch    = arch
      @mode    = mode
      p_size_t = FFI::MemoryPointer.new :ulong_long
      @p_csh    = FFI::MemoryPointer.new p_size_t
      if ( res = Binding.cs_open( arch, mode, @p_csh )).nonzero?
        Crabstone.raise_errno res
      end

      @csh = @p_csh.read_ulong_long

    end

    # After you close the engine, don't use it anymore. Can't believe I even
    # have to write this.
    def close
      if ( res = Binding.cs_close(@p_csh) ).nonzero?
        Crabstone.raise_errno res
      end
    end

    def syntax= new_stx
      Crabstone.raise_errno( Crabstone::ERRNO_KLASS[ErrOption] ) unless SYNTAX[new_stx]
      res = Binding.cs_option(csh, OPT_SYNTAX, SYNTAX[new_stx])
      Crabstone.raise_errno res if res.nonzero?
      @syntax = new_stx
    end

    def decomposer= new_val
      res = Binding.cs_option(csh, OPT_DETAIL, DETAIL[!!(new_val)])
      Crabstone.raise_errno res if res.nonzero?
      @decomposer = !!(new_val)
    end

    def version
      maj = FFI::MemoryPointer.new(:int)
      min = FFI::MemoryPointer.new(:int)
      Binding.cs_version maj, min
      [ maj.read_int, min.read_int ]
    end

    def diet?
      DIET_MODE
    end

    def errno
      Binding.cs_errno(csh)
    end

    def skipdata mnemonic='.byte'

      cfg = Binding::SkipdataConfig.new
      cfg[:mnemonic] = FFI::MemoryPointer.from_string String(mnemonic)

      if block_given?

        real_cb = FFI::Function.new(
          :size_t,
          [:pointer, :size_t, :size_t, :pointer]
        ) {|code, sz, offset, _|

          code = code.read_array_of_uchar(sz).pack('c*')
          begin
            res = yield code, offset
            Integer(res)
          rescue
            warn "Error in skipdata callback: #{$!}"
            # It will go on to crash, but now at least there's more info :)
          end
        }

        cfg[:callback] = real_cb

      end

      res = Binding.cs_option(csh, OPT_SKIPDATA_SETUP, cfg.pointer.address)
      Crabstone.raise_errno res if res.nonzero?
      res = Binding.cs_option(csh, OPT_SKIPDATA, SKIPDATA[true])
      Crabstone.raise_errno res if res.nonzero?
    end

    def skipdata_off
      res = Binding.cs_option(csh, OPT_SKIPDATA, SKIPDATA[false])
      Crabstone.raise_errno res if res.nonzero?
    end

    def reg_name regid
      Crabstone.raise_errno( Crabstone::ERRNO_KLASS[ErrDiet] ) if DIET_MODE
      name = Binding.cs_reg_name(csh, regid)
      Crabstone.raise_errno( Crabstone::ERRNO_KLASS[ErrCsh] ) unless name
      name
    end

    def disasm code, offset, count = 0
      return [] if code.empty?

      insn_ptr   = FFI::MemoryPointer.new :pointer
      insn_count = Binding.cs_disasm(
        @csh,
        code,
        code.bytesize,
        offset,
        count,
        insn_ptr
      )
      Crabstone.raise_errno(errno) if insn_count.zero?

      insns = (0...insn_count * Binding::Instruction.size).step(Binding::Instruction.size).map do |off|
        cs_insn_ptr = Binding.malloc Binding::Instruction.size
        cs_insn = Binding::Instruction.new cs_insn_ptr
        Binding.memcpy(cs_insn_ptr, insn_ptr.read_pointer + off, Binding::Instruction.size)
        Instruction.new @csh, cs_insn, @arch
      end

      Binding.free(insn_ptr.read_pointer)

      insns
    end

    def set_raw_option opt, val
      res = Binding.cs_option csh, opt, val
      Crabstone.raise_errno res if res.nonzero?
    end
  end
end
