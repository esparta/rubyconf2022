# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'business-api'
  spec.version = '0.2.0'
  spec.authors = ['esparta']
  spec.email = ['rubyconf2022.demo@esparta.co']

  spec.summary = 'Hanami app containing the Api interface'
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
  spec.add_dependency 'hanami-api', '~> 0.2.0'
end
