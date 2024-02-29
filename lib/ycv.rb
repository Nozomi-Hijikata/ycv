# frozen_string_literal: true

require_relative "ycv/version"
require_relative "ycv/to_yaml"
require_relative "ycv/to_csv"
require_relative "ycv/to_file"

module Ycv
  class Error < StandardError; end

  def self.convert(input_path, format)
    case format
    when :csv
      Ycv::ToCsv.call(input_path)
    when :yaml
      Ycv::ToYaml.call(input_path)
    else
      raise Error, "Unsupported format: #{format}"
    end
  end
end
