require '../src/address_cleaner'
require '../src/csv_reader'

RSpec.describe AddressCleaner do
  describe '.run' do
    it 'prints corrected addresses' do
      # Mock the dependencies
      csv_reader_double = double('CSVReader')
      client_double = double('SmartyStreets::Client')
      validator_double = double('AddressValidator')

      # Stub the methods
      allow(CSVReader).to receive(:new).and_return(csv_reader_double)
      allow(csv_reader_double).to receive(:read_csv).and_return(['Address 1', 'Address 2'])
      allow(AddressValidator).to receive(:new).and_return(validator_double)
      allow(validator_double).to receive(:run).and_return(['Corrected Address 1', 'Corrected Address 2'])

      # Expectations
      expect(STDOUT).to receive(:puts).with('Corrected Address 1')
      expect(STDOUT).to receive(:puts).with('Corrected Address 2')

      # Run the method
      AddressCleaner.run
    end
  end
end