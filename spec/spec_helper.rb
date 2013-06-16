#!/usr/bin/env ruby
# tags: rspec default settings wip config

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end

require "pathname"
FIXTURES_PATH = Pathname.new(File.expand_path("../fixtures", __FILE__))
