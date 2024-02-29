# frozen_string_literal: true

require "csv"
require "yaml"
require_relative "to_file"
require "active_support/all"

module Ycv
  class ToYaml
    def self.convert_to_fixtures(file_path)
      file_name = file_path[/(\w+).csv$/, 1]
      fixtures_section_name = file_name.singularize
      fixtures = {}

      CSV.foreach(file_path, headers: true) do |row|
        fixtures["#{fixtures_section_name}_#{row[0]}"] = row.to_hash.map do |k, v|
          next [k, v] if v.nil?

          value = if v.match(/\A\d*\.\d*\Z/) # 小数点を考慮
                    v.to_f
                  elsif v.match(/\A\d+\Z/) # 整数の場合
                    v.to_i
                  else
                    v
                  end
          [k, value]
        end.to_h
      end
      write_to_file(fixtures.to_yaml.sub(/---\n/, ""), "#{file_name}.yml")
    end
  end
end
