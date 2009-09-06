require 'rubygems'

begin
  require 'rake'
rescue LoadError
  puts 'This script should only be accessed via the "rake" command.'
  puts 'Installation: gem install rake -y'
  exit
end

require 'rake/clean'

require 'spec/rake/spectask'

task :default => :"spec"

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ["--format", "nested"]
  t.spec_files = FileList['spec/*_spec.rb']
end
 
namespace :spec do
  desc "Run all specs in spec directory with RCov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_files = FileList['spec/*_spec.rb']
    t.rcov = true
    t.rcov_opts = ['--exclude', 'spec']
  end
  
  desc "Print Specdoc for all specs"
  Spec::Rake::SpecTask.new(:doc) do |t|
    t.spec_opts = ["--format", "specdoc", "--dry-run"]
    t.spec_files = FileList['spec/*_spec.rb']
  end
 
end


begin
  require 'rake'
  require 'echoe'
  require File.join(File.dirname(__FILE__),'lib','fluiddb','version.rb')
  
  Echoe.new('fluidrb') do |p|
    p.description    = "Ruby FluidDB Api"
    p.summary        = "Ruby api for access to FluidDB Api"
    p.url            = "http://wiki.github.com/guillermo/fluidrb"
    p.author         = "Guillermo Álvarez"
    p.email          = "guillermo@cientifico.net"
    p.version        = FluidDB::VERSION
    #p.docs_host
    #p.rdoc_pattern
    p.runtime_dependencies = ["json > 1.1.4"]
    p.ignore_pattern = FileList[".gitignore"]
    
  end
  
  
rescue LoadError
  puts 'This script should only be accessed via the "rake" command.'
  puts 'Installation: gem install rake -y'
  exit
end
