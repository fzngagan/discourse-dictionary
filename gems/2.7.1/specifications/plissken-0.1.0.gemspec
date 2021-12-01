# -*- encoding: utf-8 -*-
# stub: plissken 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "plissken".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dave Hrycyszyn".freeze]
  s.date = "2013-02-19"
  s.description = "\n    Have you ever needed to automatically convert JSON-style camelBack or\n    CamelCase hash keys into more Rubyish snake_case?\n\n    Plissken to the rescue.\n\n    This gem recursively converts all camelBack or CamelCase keys in a hash\n    structure to snake_case.\n  ".freeze
  s.email = "dave.hrycyszyn@headlondon.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/futurechimp/plissken".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Snakify your camel keys when working with JSON APIs".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<debugger>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<jeweler>.freeze, ["~> 1.8.4"])
  else
    s.add_dependency(%q<debugger>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 1.8.4"])
  end
end
