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

task :default => :spec

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
    t.rcov_opts = ['--exclude', 'spec,gems']
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
  
  Echoe.new('fluidrb',FluidDB::VERSION) do |p|
    p.description    = "Ruby FluidDB Api"
    p.summary        = "Ruby api for access to FluidDB Api"
    p.url            = "http://wiki.github.com/guillermo/fluidrb"
    p.author         = "Guillermo Álvarez"
    p.email          = "guillermo@cientifico.net"
    p.runtime_dependencies = ["brianmario-yajl-ruby >= 0.6.3"]
    p.ignore_pattern = `cat .gitignore`.split
    
  end
  
  desc 'Prepare, commit and push to github'
  task :deploy => [:spec, :clean, :clobber, :git_clean, :manifest, :build_gemspec,:commit,:push]
  
  desc 'Commit and generate doc'
  task :commit_doc => [:git_reset, :rdoc, "spec:coverage", :checkout_gh_pages, :commit, :push, :checkout_master] 
  
  
  Rake::RDocTask.new do |rd|
    rd.rdoc_files.include("lib/**/*.rb","lib/*.rb")
    rd.options << '-d'
  end
  
  task :checkout_master do
    `git checkout master`
  end
  
  task :checkout_gh_pages do
    `git checkout gh-pages`
  end
  
  task :git_reset do 
    `git reset --hard`
  end
    
  task :push do
    puts "Uploading changes"
    `git push origin `
  end
  
  task :git_clean do 
    puts 'Removing ignored files'
    puts `git clean -fX`
  end
  
  task :commit do
    `git add . && git commit -m "Automatic build for #{FluidDB::VERSION}"`
  end
  
  task 'build_gemspec'
  
  
rescue LoadError
  puts 'This script should only be accessed via the "rake" command.'
  puts 'Installation: gem install rake -y'
  exit
end
