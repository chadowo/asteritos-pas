require 'fileutils'

class BuildConfig
  attr_accessor :name, :flags, :files, :include_dirs, :link_dirs, :out_filename

  def initialize(name)
    @name = name

    @flags = []
    @files = []

    @include_dirs = []

    @out_filename = ''

    yield self # I'd give my body for you, my liege
  end

  def build
    write_summary
    puts "\n"

    create_build_directory
    system("fpc #{@files.join(' ')} #{@flags.join(' ')} -Fu#{@include_dirs.first} -FUbuild/units -FEbuild/ -o#{@out_filename} ")

    self
  end

  def run
    system("build/#{@out_filename}")

    self
  end

  def clean
    FileUtils.remove_dir('build/')

    self
  end

  private

  def create_build_directory
    FileUtils.mkdir_p('build/units')
  end

  def write_summary
    puts <<~SUMMARY
      Build config: "#{@name}"
      FPC info: #{`fpc -v`.lines.first.chomp}
      -------------------------------------------------------------------------
      * Flags: #{@flags}
      * Files: #{@files}
      * Include dirs: #{@include_dirs}
    SUMMARY
  end
end
