# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unifi_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "unifi_gem"
  spec.version       = UnifiGem::VERSION
  spec.date          = '2019-02-26'
  spec.authors       = ["Julian Davison"]
  spec.email         = ["julian@davison.org.nz"]

  spec.summary       = %q{A Ruby interface to UniFi Controller API}
  spec.description   = %q{A Ruby interface to UniFi Controller API.}
  spec.homepage      = "https://github.com/davisonja/unifi-gem"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty", "~> 0"
end
