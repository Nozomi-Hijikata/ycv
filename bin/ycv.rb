#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/ycv"

if ARGV.empty? || ARGV.length > 2
  puts "Usage: ycv INPUT_FILE [OUTPUT_FILE]"
  exit 1
end

input_path = ARGV[0]
output_path = ARGV[1]

begin
  conversion_method = case File.extname(input_path)
                      when ".csv" then :yaml
                      when ".yml", ".yaml" then :csv
                      else raise Ycv::Error, "Unsupported file type"
                      end

  result = Ycv.convert(input_path, conversion_method)

  if output_path
    Ycv::ToFile.call(result, output_path)
    puts "Conversion successful: #{input_path} -> #{output_path || "STDOUT"}"
  else
    puts result
  end
rescue Ycv::Error => e
  puts "Error: #{e.message}"
  exit 1
end
