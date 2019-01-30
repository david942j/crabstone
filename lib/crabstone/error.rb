module Crabstone
  class ErrArch < StandardError; end
  class ErrCsh < StandardError; end
  class ErrHandle < StandardError; end
  class ErrMem < StandardError; end
  class ErrMode < StandardError; end
  class ErrOK < StandardError; end
  class ErrOption < StandardError; end
  class ErrDetail < StandardError; end
  class ErrMemSetup < StandardError; end
  class ErrVersion < StandardError; end
  class ErrDiet < StandardError; end
  class ErrSkipData < StandardError; end
  class ErrX86ATT < StandardError; end
  class ErrX86Intel < StandardError; end

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
    13 => ErrX86Intel
  }.freeze

  # TODO: remove this
  ERRNO_KLASS = ERRNO.invert

  def self.raise_errno(errno)
    err_klass = ERRNO[errno]
    raise 'Internal Error: Tried to raise unknown errno' unless err_klass

    err_str = Binding.cs_strerror(errno)
    raise err_klass, err_str
  end
end
