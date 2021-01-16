# frozen_string_literal: true

# XXX: Auto-gerneate this file?
# Error classes might be added in a newer Capstone version,
# but this should not be frequent, currently this file is updated manually.

module Crabstone
  # @private
  class Error < StandardError; end

  class ErrArch < Error; end

  class ErrCsh < Error; end

  class ErrHandle < Error; end

  class ErrMem < Error; end

  class ErrMode < Error; end

  class ErrOK < Error; end

  class ErrOption < Error; end

  class ErrDetail < Error; end

  class ErrMemSetup < Error; end

  class ErrVersion < Error; end

  class ErrDiet < Error; end

  class ErrSkipData < Error; end

  class ErrX86ATT < Error; end

  class ErrX86Intel < Error; end

  class ErrX86MASM < Error; end

  class Error
    ERRNO = {
      0 => ErrOK,
      1 => ErrMem,
      2 => ErrArch,
      3 => ErrHandle,
      4 => ErrCsh,
      5 => ErrMode,
      6 => ErrOption,
      7 => ErrDetail,
      8 => ErrMemSetup,
      9 => ErrVersion,
      10 => ErrDiet,
      11 => ErrSkipData,
      12 => ErrX86ATT,
      13 => ErrX86Intel,
      14 => ErrX86MASM
    }.freeze

    def self.raise_errno!(errno)
      err_klass = ERRNO[errno]
      raise 'Internal Error: Tried to raise unknown errno' unless err_klass

      err_str = Binding.cs_strerror(errno)
      raise err_klass, err_str
    end

    def self.raise!(klass)
      raise "Invalid error class: #{klass}" unless klass.superclass == self

      raise_errno!(ERRNO.invert[klass])
    end
  end
end
