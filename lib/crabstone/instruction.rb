# frozen_string_literal: true

require 'crabstone/constants'

module Crabstone
  class Instruction
    attr_reader :arch, :csh, :raw_insn

    ARCHS = {
      arm: ARCH_ARM,
      arm64: ARCH_ARM64,
      x86: ARCH_X86,
      mips: ARCH_MIPS,
      ppc: ARCH_PPC,
      sparc: ARCH_SPARC,
      sysz: ARCH_SYSZ,
      xcore: ARCH_XCORE
    }.invert

    ARCH_CLASSES = {
      ARCH_ARM => ARM,
      ARCH_ARM64 => ARM64,
      ARCH_X86 => X86,
      ARCH_MIPS => MIPS,
      ARCH_PPC => PPC,
      ARCH_SPARC => Sparc,
      ARCH_SYSZ => SysZ,
      ARCH_XCORE => XCore
    }.freeze

    def initialize(csh, insn, arch)
      @arch       = arch
      @csh        = csh
      @raw_insn   = insn
      init_detail(insn[:detail]) if detailed?
    end

    def name
      raise_if_diet
      name = Binding.cs_insn_name(csh, id)
      Crabstone.raise_errno(ERRNO_KLASS[ErrCsh]) unless name
      name
    end

    def group_name(grp)
      raise_if_diet
      name = Binding.cs_group_name(csh, Integer(grp))
      Crabstone.raise_errno(ERRNO_KLASS[ErrCsh]) unless name
      name
    end

    # It's more informative to raise if CS_DETAIL is off than just return nil
    def detailed?
      !@raw_insn[:detail].pointer.null?
    end

    def detail
      raise_unless_detailed
      @detail
    end

    def regs_read
      raise_unless_detailed
      raise_if_diet
      @regs_read
    end

    def regs_write
      raise_unless_detailed
      raise_if_diet
      @regs_write
    end

    def groups
      raise_unless_detailed
      raise_if_diet
      @groups
    end

    def group?(groupid)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_insn_group csh, raw_insn, groupid
    end

    def reads_reg?(reg)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_reg_read csh, raw_insn, ARCH_CLASSES[arch].register(reg)
    end

    def writes_reg?(reg)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_reg_write csh, raw_insn, ARCH_CLASSES[arch].register(reg)
    end

    def mnemonic
      raise_if_diet
      raw_insn[:mnemonic]
    end

    def op_str
      raise_if_diet
      raw_insn[:op_str]
    end

    def op_count(op_type = nil)
      raise_unless_detailed
      if op_type
        Binding.cs_op_count csh, raw_insn, op_type
      else
        operands.size
      end
    end

    def bytes
      raw_insn[:bytes].first raw_insn[:size]
    end

    # So an Instruction should respond to all the methods in Instruction, and
    # all the methods in the Arch specific Instruction class. The methods /
    # members that have special handling for detail mode or diet mode are
    # handled above. The rest is dynamically dispatched below.
    def method_missing(meth, *args)
      if raw_insn.members.include?(meth)
        # Dispatch to toplevel Instruction class ( this file )
        raw_insn[meth]
      else
        # Nothing else is available without details.
        unless detailed?
          raise(
            NoMethodError,
            "Either CS_DETAIL is off, or #{self.class} doesn't implement #{meth}"
          )
        end
        # Dispatch to the architecture specific Instruction ( in arch/ )
        if @arch_insn.respond_to?(meth)
          @arch_insn.__send__(meth, *args)
        elsif @arch_insn.members.include?(meth)
          @arch_insn[meth]
        else
          super
        end
      end
    end

    def respond_to_missing?(meth)
      return true if raw_insn.members.include?(meth)
      return false unless detailed?
      return true if @arch_insn.respond_to?(meth)
      return true if @arch_insn.members.include?(meth)

      false
    end

    private

    def raise_unless_detailed
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrDetail]) unless detailed?
    end

    def raise_if_diet
      Crabstone.raise_errno(Crabstone::ERRNO_KLASS[ErrDiet]) if DIET_MODE
    end

    def init_detail(detail)
      @detail     = detail
      @arch_insn  = @detail[:arch][ARCHS[arch]]
      @regs_read  = @detail[:regs_read].first(@detail[:regs_read_count])
      @regs_write = @detail[:regs_write].first(@detail[:regs_write_count])
      @groups     = @detail[:groups].first(@detail[:groups_count])
    end
  end
end
