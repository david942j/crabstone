# frozen_string_literal: true

desc 'To auto-generate files under lib/crabstone/binding/'
task :gen_binding, :path_to_capstone, :version do |_t, args|
  next if ENV['CI']

  @cs_path = File.expand_path(args.path_to_capstone)
  @version = Versionomy.parse(args.version)
  @target_dir = File.join(__dir__, '..', 'lib', 'crabstone', 'binding', @version.major.to_s)

  FileUtils.mkdir_p(@target_dir)

  def gen_structs; end

  def write_dotversion
    File.open(File.join(@target_dir, '.version'), 'w') do |f|
      f.puts @version
    end
  end

  gen_structs
  write_dotversion

  Rake::Task['rubocop:auto_correct'].invoke
end
