require 'csv'

class CSVReader
  def initialize(file_path)
    @file_path = file_path
  end

  def read_csv
    entries = []
    CSV.foreach(@file_path, headers: true) do |row|
      entries << row.to_h
    end
    entries
  end
end