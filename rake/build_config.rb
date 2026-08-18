require 'fileutils'

class BuildConfig
  attr_accessor :name, :flags, :files, :include_dirs, :link_dirs, :out_filename, :silent

  def initialize(name)
    @name = name

    @flags = []
    @files = []
    @defines = []

    @include_dirs = []

    @out_filename = ''
    @silent = false

    yield self # I'd give my body for you, my liege
  end

  def enable_debug
    @flags << '-g' # GDB debug info
    @flags << '-gl' # Lineinfo unit for line information

    # Checks
    @flags << '-Ci' # I/O
    @flags << '-Co' # Overflow of integer operations
    @flags << '-CO'
    @flags << '-Cr' # Range checking
    @flags << '-CR' # Verify object method call validity

    #@flags << '-gv' # Valgrind debug info

    @defines << '-dDEBUG'
  end

  def build
    command = "fpc #{@files.join(' ')} #{@flags.join(' ')} #{@defines.join(' ')} #{@include_dirs.each { |d| d.prepend('-Fu') }.join(' ')} -FUbuild/units -FEbuild/ -o#{@out_filename}"

    unless @silent
      write_summary
      puts "Final command: #{command}"
    end

    create_build_directory
    system(command)

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
      * Flags: #{@flags}
      * Files: #{@files}
      * Include dirs: #{@include_dirs}
      -------------------------------------------------------------------------
    SUMMARY
  end
end
