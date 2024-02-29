# frozen_string_literal: true

module Ycv
  class ToFile
    def self.call(data, file_name)
      File.open(file_name, "w+") do |f|
        f.write(data)
      end
    end
  end
end
