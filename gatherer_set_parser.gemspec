# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gatherer_set_parser/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Ratajczak"]
  gem.email         = ["david@mockra.com"]
  gem.description   = %q{Parses the MTG Gatherer website for a collection of
                        cards from the provided set.}
  gem.summary       = %q{This gem will return an array of card hashes that you
                        can use to build a database of Magic the Gathering cards.}
  gem.homepage      = "https://github.com/mockra/gatherer_set_parser"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gatherer_set_parser"
  gem.require_paths = ["lib"]
  gem.version       = GathererSetParser::VERSION
  gem.license       = 'MIT'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'vcr'
  gem.add_dependency 'nokogiri'
end
