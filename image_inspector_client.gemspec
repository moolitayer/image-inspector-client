# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_inspector_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'image_inspector_client'
  spec.version       = ImageInspectorClient::VERSION
  spec.authors       = ['Mooli Tayer']
  spec.email         = ['mtayer@redhat.com']
  spec.summary       = 'A client for image_inspector REST API'
  spec.description   = 'A client for image_inspector REST API'
  spec.homepage      = 'https://github.com/moolitayer/image_inspector_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop', '= 0.30.0'

  spec.add_dependency 'json'
  spec.add_dependency 'recursive-open-struct', '= 0.6.1'
  spec.add_dependency 'rest-client'
end
