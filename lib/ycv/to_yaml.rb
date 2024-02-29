# frozen_string_literal: true

require "csv"
require "yaml"
require "active_support/all"

module Ycv
  class ToYaml
    def self.call(file_path)
      file_name = extract_file_name(file_path)
      fixtures_section_name = file_name.singularize
      fixtures = process_csv_rows(file_path, fixtures_section_name)
      convert_to_yaml(fixtures)
    end

    def self.extract_file_name(file_path)
      file_path[/(\w+).csv$/, 1]
    end

    def self.process_csv_rows(file_path, section_name)
      fixtures = {}
      CSV.foreach(file_path, headers: true) do |row|
        key = "#{section_name}_#{row[0]}"
        fixtures[key] = process_row(row)
      end
      fixtures
    end

    def self.process_row(row)
      row.to_hash.transform_values do |value|
        parse_value(value)
      end
    end

    def self.parse_value(value)
      case value
      when /\A\d*\.\d*\Z/ then value.to_f
      when /\A\d+\Z/ then value.to_i
      else value
      end
    end

    def self.convert_to_yaml(data)
      yaml_content = data.to_yaml
      yaml_content.gsub!(/'([^']*)'/, '\1')
      yaml_content.sub!(/---\n/, "")
      yaml_content
    end
  end
end
