# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jwt/rack/version'

Gem::Specification.new do |spec|
  spec.name          = 'jwt-rack'
  spec.version       = JWT::Rack::VERSION
  spec.authors       = ['Yaroslav Savchuk']
  spec.email         = ['savchukyarpolk@gmail.com']

  spec.summary       = 'Rack middleware that provides authentication based on JSON Web Tokens.'
  spec.description   = 'Rack middleware that provides authentication based on JSON Web Tokens.'
  spec.homepage      = 'https://github.com/ysv/jwt-rack'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ysv/jwt-rack'
  spec.metadata['changelog_uri'] = 'https://github.com/ysv/jwt-rack/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.3.8'

  spec.add_development_dependency 'bundler', '>= 1.16.2'
  spec.add_development_dependency 'pry-byebug', '~> 3.7'
  spec.add_development_dependency 'rack-test', '>= 1.0.0'
  spec.add_development_dependency 'rake',      '>= 12.0.0'
  spec.add_development_dependency 'rbnacl',    '>= 6.0.1'
  spec.add_development_dependency 'rspec',     '>= 3.8.0'
  spec.add_development_dependency 'simplecov', '>= 0.16.0'

  spec.add_runtime_dependency 'jwt', '~> 2.1.0'
  spec.add_runtime_dependency 'rack'
end
