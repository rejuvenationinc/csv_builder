# encoding: utf-8

module CsvBuilder
  if RUBY_VERSION.to_f >= 1.9
    require 'csv'
    CSV = ::CSV
  else
    require 'fastercsv'
    CSV = ::FasterCSV
  end
end

require 'action_view'
require 'csv_builder/proxy'
require 'csv_builder/filter_proxy'
require 'csv_builder/csv_proxy'
require 'csv_builder/template_handler'
require 'csv_builder/railtie'