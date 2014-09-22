# -*- encoding: utf-8 -*-
# stub: docker_registry 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "docker_registry"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sho Kusano"]
  s.date = "2014-09-20"
  s.description = "Docker registry HTTP API client"
  s.email = ["rosylilly@aduca.org"]
  s.files = [".gitignore", ".rubocop.yml", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "docker_registry.gemspec", "lib/docker_registry.rb", "lib/docker_registry/client.rb", "lib/docker_registry/oj_parser.rb", "lib/docker_registry/registry.rb", "lib/docker_registry/repository.rb", "lib/docker_registry/tag.rb", "lib/docker_registry/version.rb"]
  s.homepage = "https://github.com/rosylilly/docker_registry"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Docker registry HTTP API client"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rubocop>, [">= 0.26.0"])
      s.add_runtime_dependency(%q<faraday>, [">= 0"])
      s.add_runtime_dependency(%q<faraday_middleware>, [">= 0"])
      s.add_runtime_dependency(%q<oj>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rubocop>, [">= 0.26.0"])
      s.add_dependency(%q<faraday>, [">= 0"])
      s.add_dependency(%q<faraday_middleware>, [">= 0"])
      s.add_dependency(%q<oj>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rubocop>, [">= 0.26.0"])
    s.add_dependency(%q<faraday>, [">= 0"])
    s.add_dependency(%q<faraday_middleware>, [">= 0"])
    s.add_dependency(%q<oj>, [">= 0"])
  end
end
