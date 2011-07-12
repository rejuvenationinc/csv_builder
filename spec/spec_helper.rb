# encoding: utf-8

ENV["RAILS_ENV"] ||= 'test'
rails_root = File.expand_path('../rails_app', __FILE__)
require rails_root + '/config/environment.rb'

require 'rspec/rails'

TEST_DATA = [
  ['Lorem', 'ipsum'],
  ['Lorem ipsum dolor sit amet,' 'consectetur adipiscing elit. Sed id '],
  ['augue! "3" !@#$^&*()_+_', 'sed risus laoreet condimentum ac nec dui.'],
  ['\'Aenean sagittis lorem ac', 'lorem comm<s>odo nec eleifend risus']
]

def generate(options = {}, data = TEST_DATA)
  output = String.new
  output.force_encoding(options[:output_encoding] || CsvBuilder::DEFAULT_OUTPUT_ENCODING)
  csv = CsvBuilder::CsvProxy.new(output, options)
  data.each do |row|
    csv << row
  end
  output
end
