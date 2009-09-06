# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fluidrb}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guillermo \303\201lvarez"]
  s.cert_chain = ["/Users/guillermo/.rubygems/gem-public_cert.pem"]
  s.date = %q{2009-09-06}
  s.description = %q{Ruby api for access to FluidDB Api}
  s.email = %q{}
  s.executables = ["fluiddb", "fluiddb-sandbox"]
  s.extra_rdoc_files = ["README.md", "bin/fluiddb", "bin/fluiddb-sandbox", "lib/fluiddb.rb", "lib/fluiddb/connection.rb", "lib/fluiddb/console/common.rb", "lib/fluiddb/console/console.rb", "lib/fluiddb/console/sandbox.rb", "lib/fluiddb/error.rb", "lib/fluiddb/namespace.rb", "lib/fluiddb/object.rb", "lib/fluiddb/resource.rb", "lib/fluiddb/tag.rb", "lib/fluiddb/user.rb", "lib/fluiddb/version.rb"]
  s.files = ["Manifest", "README.md", "Rakefile", "bin/fluiddb", "bin/fluiddb-sandbox", "lib/fluiddb.rb", "lib/fluiddb/connection.rb", "lib/fluiddb/console/common.rb", "lib/fluiddb/console/console.rb", "lib/fluiddb/console/sandbox.rb", "lib/fluiddb/error.rb", "lib/fluiddb/namespace.rb", "lib/fluiddb/object.rb", "lib/fluiddb/resource.rb", "lib/fluiddb/tag.rb", "lib/fluiddb/user.rb", "lib/fluiddb/version.rb", "spec/namespace_spec.rb", "spec/object_spec.rb", "spec/spec_helper.rb", "spec/tag_spec.rb", "spec/user_spec.rb", "fluidrb.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://wiki.github.com/guillermo/fluidrb}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fluidrb", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fluidrb}
  s.rubygems_version = %q{1.3.1}
  s.signing_key = %q{/Users/guillermo/.rubygems/gem-private_key.pem}
  s.summary = %q{Ruby api for access to FluidDB Api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0", "= 1.1.3"])
    else
      s.add_dependency(%q<json>, [">= 0", "= 1.1.3"])
    end
  else
    s.add_dependency(%q<json>, [">= 0", "= 1.1.3"])
  end
end
