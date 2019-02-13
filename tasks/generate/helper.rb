# frozen_string_literal: true

module Generate
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
  end
end
