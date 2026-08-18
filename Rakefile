require 'fileutils'

require_relative 'rake/build_config'

@default_build = BuildConfig.new('Linux-x86_64') do |conf|
  conf.files << 'src/Main.pas'

  # Just a reminder
  # -MObjFPC: Object Pascal mode.
  # -O1: Level 1 optimizations
  # -Ci: I/O checking.
  # -Co: Integer overflow checking.
  # -CO: *Possible* integer overflow (dunno exactly but seems useful).
  # -Cr: Range checking.
  # -CR: Object method call validity checking.
  # -Sh: AnsiString default
  # -Sy: Typed pointers
  # -Sc: C compound assignment operators
  # -XX: Try to smart link (Reduces size in most cases)
  conf.flags =
    %w(-Mobjfpc -O1 -Ci -Co -CO -Cr -CR -Sh -Sy -Sc -XX)
  conf.include_dirs = %w(src/states/ src/entities/ external/sdl2-pascal/)

  conf.out_filename = 'asteritos'
  conf.silent = true

  conf.enable_debug
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

task :test do
  sh 'fpc test/TestRunner.lpr -Fusrc/'
  sh 'test/TestRunner'
end
