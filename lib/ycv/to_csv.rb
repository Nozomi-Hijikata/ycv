# frozen_string_literal: true

require "csv"
require "yaml"

module Ycv
  class ToCsv
    def self.call(file_path)
      file_path[/(\w+).yml$/, 1]
      fixtures = YAML.load_file(file_path)
      headers = fixtures.first[1].keys
      CSV.generate do |c|
        c << headers
        fixtures.each_value do |v|
          c << v.values
        end
      end
    end
  end
end
