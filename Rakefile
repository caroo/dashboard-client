begin
  require 'rubygems/package_task'
rescue LoadError => e
  warn "Caught #{e.class}: #{e}"
end
require 'rake/clean'
require 'rake/testtask'
require 'rcov/rcovtask'
require 'rbconfig'
include Config

PKG_NAME = 'dashboard-client'
PKG_VERSION = File.read('VERSION').chomp
PKG_FILES = FileList[`git ls-files`.split("\n")].exclude(/\A\./)
CLEAN.include 'doc'

if defined? Gem
  spec = Gem::Specification.new do |s|
    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.summary = 'Client library for the dashboard service'
    s.description = 'This library is used to send monitoring data from the applications to the dashboard service.'

    s.add_dependency('spruz', '~>0.2.8')
    s.add_dependency('dslkit', '~>0.2.6')
    s.add_dependency('json', '~>1.5.3')
    s.add_dependency('cpu', '~>0.0.1')
    s.add_dependency('yahoo_weatherman', '~>1.1.3')
    s.add_dependency('activerecord', '~>3.0.9')

    s.files = PKG_FILES

    s.require_path = 'lib'
    s.executable = 'dashboard'

    s.rdoc_options << '--main' << 'README.markdown'
    s.extra_rdoc_files << 'README.markdown'
    s.test_files.concat Dir['test/**/*_test.rb']

    s.author = "Pkw.de Development Team"
    s.email = "dev@pkw.de"
    s.homepage = "http://pkw.de"
  end

  task :gemspec => :version do
    File.open("#{PKG_NAME}.gemspec", 'w') do |f|
      f.write spec.to_ruby
    end
  end

  Gem::PackageTask.new(spec) do |pkg|
    pkg.need_tar = true
    pkg.package_files += PKG_FILES
  end
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose    = true
end

Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose    = true
  t.rcov_opts = %w[-x '\\btests\/' -x '\\bgems\/']
end

desc m = "Writing version information for #{PKG_VERSION}"
task :version do
  puts m
  File.open(File.join('lib', 'dashboard', 'version.rb'), 'w') do |v|
    v.puts <<EOT
module Dashboard
  # Dashboard version
  VERSION         = '#{PKG_VERSION}'
  VERSION_ARRAY   = VERSION.split(/\\./).map { |x| x.to_i } # :nodoc:
  VERSION_MAJOR   = VERSION_ARRAY[0] # :nodoc:
  VERSION_MINOR   = VERSION_ARRAY[1] # :nodoc:
  VERSION_BUILD   = VERSION_ARRAY[2] # :nodoc:
end
EOT
  end
end

desc 'Install the current bundle'
task :bundle do
  sh 'bundle'
end

desc "Default"
task :default => [ :gemspec, :bundle, :test ]

desc "Prepare a release"
task :release => [ :clean, :gemspec, :bundle, :package ]
