# frozen_string_literal: true

require 'crabstone/arch'
require 'crabstone/binding'
require 'crabstone/constants'
require 'crabstone/error'

module Crabstone
  class Instruction
    attr_reader :csh, :raw_insn

    def initialize(csh, insn, arch)
      @arch_module = Arch.module_of(arch)
      @csh = csh
      @raw_insn = insn
      init_detail(insn[:detail]) if detailed?
    end

    def name
      raise_if_diet
      name = Binding.cs_insn_name(csh, id)
      Crabstone::Error.raise!(ErrCsh) unless name
      name
    end

    def group_name(grp)
      raise_if_diet
      name = Binding.cs_group_name(csh, Integer(grp))
      Crabstone::Error.raise!(ErrCsh) unless name
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

    def group?(group_id)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_insn_group(csh, raw_insn, group_id)
    end

    def reads_reg?(reg)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_reg_read(csh, raw_insn, @arch_module.register(reg))
    end

    def writes_reg?(reg)
      raise_unless_detailed
      raise_if_diet
      Binding.cs_reg_write(csh, raw_insn, @arch_module.register(reg))
    end

    # @return [{:regs_read => Array<Integer>, :regs_write => Array<Integer>}]
    def regs_access
      raise_unless_detailed
      raise_if_diet

      # XXX: Becare of if `typedef uint16_t cs_regs[64];` changes
      regs_read = FFI::MemoryPointer.new(:uint16, 64)
      regs_read_count = FFI::MemoryPointer.new(:uint8)
      regs_write = FFI::MemoryPointer.new(:uint16, 64)
      regs_write_count = FFI::MemoryPointer.new(:uint8)
      err = Binding.cs_regs_access(csh, raw_insn, regs_read, regs_read_count, regs_write, regs_write_count)
      Crabstone::Error.raise_errno(err) if err.nonzero?
      {
        regs_read: regs_read.read_array_of_short(regs_read_count.read_int8),
        regs_write: regs_write.read_array_of_short(regs_write_count.read_int8)
      }
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
        Binding.cs_op_count(csh, raw_insn, op_type)
      else
        operands.size
      end
    end

    def bytes
      raw_insn[:bytes].first(raw_insn[:size])
    end

    # So an Instruction should respond to all the methods in Instruction, and
    # all the methods in the Arch specific Instruction class. The methods /
    # members that have special handling for detail mode or diet mode are
    # handled above. The rest is dynamically dispatched below.
    def method_missing(meth, *args)
      # Dispatch to toplevel Instruction class ( this file )
      return raw_insn[meth] if raw_insn.members.include?(meth)

      # Nothing else is available without details.
      unless detailed?
        raise(
          NoMethodError,
          "Either CS_DETAIL is off, or #{self.class} doesn't implement #{meth}"
        )
      end
      # Dispatch to the architecture specific Instruction ( in arch/ )
      return @arch_insn.__send__(meth, *args) if @arch_insn.respond_to?(meth)
      return @arch_insn[meth] if @arch_insn.members.include?(meth)

      super
    end

    def respond_to_missing?(meth, include_private = true)
      return true if raw_insn.members.include?(meth)
      return super unless detailed?
      return true if @arch_insn.respond_to?(meth)
      return true if @arch_insn.members.include?(meth)

      super
    end

    private

    def raise_unless_detailed
      Crabstone::Error.raise!(ErrDetail) unless detailed?
    end

    def raise_if_diet
      Crabstone::Error.raise!(ErrDiet) if DIET_MODE
    end

    def init_detail(detail)
      @detail     = detail
      @arch_insn  = @detail[:arch][arch_field]
      @regs_read  = @detail[:regs_read].first(@detail[:regs_read_count])
      @regs_write = @detail[:regs_write].first(@detail[:regs_write_count])
      @groups     = @detail[:groups].first(@detail[:groups_count])
    end

    # Find the field name of Architecture.
    def arch_field
      klass = @arch_module.const_get(:Instruction)
      obj = Binding::Architecture.new
      Binding::Architecture.members.find do |sym|
        obj[sym].instance_of?(klass)
      end
    end
  end
end
