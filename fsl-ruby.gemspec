# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fsl-ruby/version'

Gem::Specification.new do |gem|
  gem.name          = "fsl-ruby"
  gem.version       = FSL::VERSION
  gem.authors       = ["Simon Rascovsky"]
  gem.email         = ["simonmd@gmail.com"]
  gem.description   = %q{Ruby Wrapper for the FSL Neuroimaging suite}
  gem.summary       = %q{Ruby Wrapper for the FSL Neuroimaging suite}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
