# frozen_string_literal: true

require 'crabstone/cs_version'

# require all files under 'crabstone/arch/<cs_major_version>'
Dir.glob(File.join(__dir__, 'arch', Crabstone.cs_major_version.to_s, '*.rb')).each do |f|
  require f
end
