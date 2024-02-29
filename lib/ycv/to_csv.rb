# frozen_string_literal: true

require "csv"
require "yaml"
require_relative "to_file"

module Ycv
  class ToCsv
    def self.call(file_path)
      file_name = file_path[/(\w+).yml$/, 1]
      fixtures = YAML.load_file(file_path)
      headers = fixtures.first[1].keys
      csv = CSV.generate do |c|
        c << headers
        fixtures.each_value do |v|
          c << v.values
        end
      end
      ToFile.call(csv, "#{file_name}.csv")
    end
  end
end
