# frozen_string_literal: true

require_relative "../spec_helper"
require_relative "../../lib/ycv/to_file"

RSpec.describe Ycv::ToFile do
  describe ".call" do
    let(:file_name) { "tmp/test_output.txt" }
    let(:data) { "This is a test." }

    before do
      Dir.mkdir("tmp") unless Dir.exist?("tmp")
    end

    after do
      File.delete(file_name) if File.exist?(file_name)
      Dir.rmdir("tmp") if Dir.exist?("tmp")
    end

    it "writes the data to the specified file" do
      described_class.call(data, file_name)

      expect(File.exist?(file_name)).to be true
      content = File.read(file_name)
      expect(content).to eq("This is a test.")
    end
  end
end
