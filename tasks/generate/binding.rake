# frozen_string_literal: true

require_relative 'binding'

namespace :generate do
  desc 'To auto-generate files under lib/crabstone/binding/'
  task :binding, :path_to_capstone, :version do |_t, args|
    Generate::Binding.new(args.path_to_capstone, args.version, 'lib/crabstone/binding').tap do |g|
      g.gen_detail
      g.gen_instruction
      g.write_dotversion
    end
  end
end
