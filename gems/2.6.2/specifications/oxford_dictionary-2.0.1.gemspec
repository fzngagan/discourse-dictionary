# -*- encoding: utf-8 -*-
# stub: oxford_dictionary 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "oxford_dictionary".freeze
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["swcraig".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-07-02"
  s.description = "https://developer.oxforddictionaries.com/documentation".freeze
  s.email = ["coverless.info@gmail.com".freeze]
  s.homepage = "https://github.com/swcraig/oxford-dictionary".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A wrapper for the Oxford Dictionary API".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.45.0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 5.0.0"])
      s.add_runtime_dependency(%q<plissken>.freeze, ["~> 0.1.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.45.0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<vcr>.freeze, ["~> 5.0.0"])
      s.add_dependency(%q<plissken>.freeze, ["~> 0.1.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.45.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, ["~> 5.0.0"])
    s.add_dependency(%q<plissken>.freeze, ["~> 0.1.0"])
  end
end
