# frozen_string_literal: true

require "csv"
require "yaml"
require_relative "to_file"

module Ycv
  class ToCsv
    def self.convert_to_csv(file_path)
      file_name = file_path[/(\w+).yml$/, 1]
      fixtures = YAML.load_file(file_path)
      headers = fixtures.first[1].keys
      csv = CSV.generate do |csv|
        csv << headers
        fixtures.each_value do |v|
          csv << v.values
        end
      end
      write_to_file(csv, "#{file_name}.csv")
    end
  end
end
