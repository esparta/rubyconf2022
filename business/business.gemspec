# frozen_string_literal: true

require_relative 'lib/business/version'

Gem::Specification.new do |spec|
  spec.name = 'business'
  spec.version = Business::VERSION
  spec.authors = ['esparta']
  spec.email = ['rubyconf2022.demo@esparta.co']

  spec.summary = 'Classes for our Business Contracts to validate params & payloads'
  spec.description = 'This is demo for RubyConf 2022 using Dry::(Schema|Validation)'
  spec.homepage = 'https://github.com/esparta/rubyconf2022'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['allowed_push_host'] = "'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/esparta/rubyconf2022'
  spec.metadata['changelog_uri'] = 'https://github.com/esparta/rubyconf2022'

  spec.files = Dir['CHANGELOG.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'dry-monads', '~> 1.3'
  spec.add_dependency 'dry-schema', '~> 1.10'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
