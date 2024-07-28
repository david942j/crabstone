# frozen_string_literal: true

import 'tasks/generate/arch.rake'
import 'tasks/generate/binding.rake'

namespace :generate do
  desc 'Invoke generate:arch and generate:binding. Example: rake "generate:all[$HOME/capstone-5.0.1, 5]"'
  task :all, :path_to_capstone, :version do |_t, args|
    Rake::Task['generate:arch'].invoke(args.path_to_capstone, args.version)
    Rake::Task['generate:binding'].invoke(args.path_to_capstone, args.version)

    Rake::Task['rubocop:auto_correct'].invoke
  end
end
