# -*- encoding: utf-8 -*-
require File.expand_path('../lib/csv_builder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = [%q{Econsultancy}, %q{Vidmantas Kabosis}, %q{Gabe da Silveira}, %q{Andrew Bennett}]
  gem.email         = ["andrew@delorum.com", %q{gabe@websaviour.com}]
  gem.description   = %q{CSV template handler for Rails.  Enables :format => 'csv' in controllers, with templates of the form report.csv.csvbuilder.}
  gem.summary       = %q{CSV template handler for Rails}
  gem.homepage      = 'http://github.com/potatosalad/csv_builder'
  gem.licenses      = [%q{MIT}]

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "csv_builder"
  gem.require_paths = ['lib']
  gem.version       = CsvBuilder::VERSION
  gem.requirements  = [%q{iconv}, %q{Ruby 1.9.x or FasterCSV}]

  gem.add_dependency "rails", ">= 3.0.0"
end

