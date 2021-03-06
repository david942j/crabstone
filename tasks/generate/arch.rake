# frozen_string_literal: true

require_relative 'arch'

namespace :generate do
  desc 'To auto-generate files under lib/crabstone/arch/'
  task :arch, :path_to_capstone, :version do |_t, args|
    Generate::Arch.new(args.path_to_capstone, args.version, 'lib/crabstone/arch').tap do |g|
      # gen_consts must be invoked before gen_structs
      g.gen_consts
      g.gen_structs
      g.write_dotversion
    end
  end
end
