
require 'csv'
require '../src/csv_reader'

RSpec.describe CSVReader do
  describe '#read_csv' do
    let(:file_path) { 'test.csv' } # Specify the path to a test CSV file

    it 'reads and returns CSV entries' do
      # Create a test CSV file
      CSV.open(file_path, 'w') do |csv|
        csv << ['Name', 'Email']
        csv << ['John Doe', 'john.doe@example.com']
        csv << ['Jane Smith', 'jane.smith@example.com']
      end

      # Instantiate the CSVReader with the test file path
      csv_reader = CSVReader.new(file_path)

      # Call the read_csv method and verify the result
      entries = csv_reader.read_csv
      expect(entries).to be_an(Array)
      expect(entries.size).to eq(2)
      expect(entries[0]['Name']).to eq('John Doe')
      expect(entries[0]['Email']).to eq('john.doe@example.com')
      expect(entries[1]['Name']).to eq('Jane Smith')
      expect(entries[1]['Email']).to eq('jane.smith@example.com')

      # Delete the test CSV file
      File.delete(file_path)
    end
  end
end
