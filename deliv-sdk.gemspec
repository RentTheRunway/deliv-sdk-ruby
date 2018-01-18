# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deliv/version'

Gem::Specification.new do |spec|
  spec.name = 'deliv-sdk'
  spec.version = Deliv::VERSION
  spec.authors = ['Pat Newell']
  spec.email = ['pnewell+git@renttherunway.com']

  spec.summary = 'SDK to wrap the Deliv API'
  spec.description = <<-EOB
    Always a work in progress, this gem was developed to cover the read-only
    needs of a project displaying package information to users. Feel free to
    add the write features!
  EOB
  spec.homepage = 'https://www.github.com/RentTheRunway/deliv-sdk-ruby'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    fail \
      'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files =
    `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'typhoeus', '>= 0.7'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
