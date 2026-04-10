require 'fileutils'

require_relative 'rake/build_config'

@default_build = BuildConfig.new('Linux-x86_64') do |conf|
  conf.files << 'src/Main.pas'
  conf.include_dirs = %w(external/sdl2-pascal/)

  conf.out_filename = 'asteritos'
end

task default: :build

desc 'Build the project using Free Pascal and run it'
task :build do
  @default_build.build
end

desc 'Run the game'
task :run do
  unless File.exist?("build/#{@default_build.out_filename}")
    raise 'Game is not built! Build it using: rake build'
  end

  @default_build.run
end

desc 'Clear the build directory'
task :clean do
  @default_build.clean
end
