# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/ycv/to_yaml"

RSpec.describe Ycv::ToYaml do
  describe ".extract_file_name" do
    it "extracts the file name without extension" do
      file_path = "path/to/sample.csv"
      expect(described_class.send(:extract_file_name, file_path)).to eq("sample")
    end
  end

  describe ".process_csv_rows" do
    let(:csv_path) { "spec/fixtures/file/sample.csv" }
    let(:section_name) { "sample" }
    it "processes csv rows into a hash" do
      processed_rows = described_class.send(:process_csv_rows, csv_path, section_name)
      expect(processed_rows).to be_a(Hash)
      expect(processed_rows.keys.first).to start_with(section_name)
    end
  end

  describe ".process_row" do
    it "converts csv row to hash with parsed values" do
      row = CSV::Row.new(%w[id name status time_stamp], [1, "Sample", "Active", "2023-01-01 10:00:00"])
      processed_row = described_class.send(:process_row, row)
      expect(processed_row["id"]).to be_a(Integer)
      expect(processed_row["name"]).to eq("Sample")
      expect(processed_row["status"]).to eq("Active")
      expect(processed_row["time_stamp"]).to eq("2023-01-01 10:00:00")
    end
  end

  describe ".parse_value" do
    it "parses string value to appropriate data type" do
      expect(described_class.send(:parse_value, "123")).to be_a(Integer)
      expect(described_class.send(:parse_value, "12.3")).to be_a(Float)
      expect(described_class.send(:parse_value, "Sample")).to eq("Sample")
    end
  end

  describe ".convert_to_yaml" do
    it "converts hash data to yaml format" do
      data = { "sample_1" => { "id" => 1, "name" => "Sample" } }
      yaml_data = described_class.send(:convert_to_yaml, data)
      expect(yaml_data).to start_with("sample_1:")
    end
  end

  describe ".call" do
    let(:csv_path) { "spec/fixtures/file/sample.csv" }
    let(:yaml_path) { "sample.yml" }
    let(:expected_yaml_content) do
      <<-YAML.strip_heredoc
        sample_1:
          id: 1
          name: Sample Name 1
          status: Active
          time_stamp: '2023-01-01 10:00:00'
        sample_2:
          id: 2
          name: Sample Name 2
          status: Inactive
          time_stamp: '2023-01-02 11:00:00'
      YAML
    end

    it "processes CSV file and generates expected YAML content" do
      result = described_class.call(csv_path)
      expect(result).to eq(expected_yaml_content)
    end
  end
end
