# frozen_string_literal: true

require_relative "../spec_helper"
require_relative "../../lib/ycv/to_csv"

RSpec.describe Ycv::ToCsv do
  describe ".call" do
    let(:file_path) { "path/to/fixtures.yml" }
    let(:file_name) { "fixtures" }
    let(:fixtures) do
      {
        "one" => { "id" => 1, "name" => "Test One" },
        "two" => { "id" => 2, "name" => "Test Two" }
      }
    end
    let(:expected_csv) do
      "id,name\n1,Test One\n2,Test Two\n"
    end

    before do
      allow(YAML).to receive(:load_file).with(file_path).and_return(fixtures)
      allow(Ycv::ToFile).to receive(:call)
    end

    it "converts YAML fixtures to CSV and writes to a file" do
      described_class.call(file_path)

      expect(YAML).to have_received(:load_file).with(file_path)
      expect(Ycv::ToFile).to have_received(:call).with(expected_csv, "#{file_name}.csv")
    end
  end
end
