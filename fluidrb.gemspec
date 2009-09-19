# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fluidrb}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guillermo \303\201lvarez"]
  s.date = %q{2009-09-19}
  s.description = %q{Ruby FluidDB Api}
  s.email = %q{guillermo@cientifico.net}
  s.files = ["fluidrb.gemspec", "Rakefile"]
  s.has_rdoc = true
  s.homepage = %q{http://wiki.github.com/guillermo/fluidrb}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fluidrb", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fluidrb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby api for access to FluidDB Api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<brianmario-yajl-ruby>, [">= 0", "= 0.6.3"])
    else
      s.add_dependency(%q<brianmario-yajl-ruby>, [">= 0", "= 0.6.3"])
    end
  else
    s.add_dependency(%q<brianmario-yajl-ruby>, [">= 0", "= 0.6.3"])
  end
end
