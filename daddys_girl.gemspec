# -*- encoding: utf-8 -*-
require File.expand_path('../lib/daddys_girl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kurt Preston"]
  gem.email         = ["development@inventables.com"]
  gem.description   = "Rubygem to provide object_daddy-like syntax for factory_girl"
  gem.summary       = "[Object] Daddy's [Factory] Girl"
  gem.homepage      = "https://github.com/inventables/daddys_girl"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "daddys_girl"
  gem.require_paths = ["lib"]
  gem.version       = DaddysGirl::VERSION
  gem.add_dependency "activerecord", "~> 3.0.0"
  gem.add_dependency "factory_girl", "~> 2.0"
  gem.add_development_dependency "rspec", "~> 2.0"
  gem.add_development_dependency "sqlite3-ruby"
end

