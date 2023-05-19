require 'rspec'
require 'rspec/mocks'
require '../src/address_validator.rb'
require 'smartystreets_ruby_sdk/us_street'    
require 'smartystreets_ruby_sdk/client_builder'

RSpec.describe AddressValidator do
  let(:client) { double }
  let(:addresses) { 
    [
        { 'Street' => '143 e Main Street', 'City' => 'Columbus', 'Zip Code' => '43215' }
    ] 
  }

  subject { described_class.new(client, addresses) }

  describe '#run' do
    let(:lookup) { instance_double(SmartyStreets::USStreet::Lookup) }
    let(:result) { [] }

    before do
      allow(SmartyStreets::USStreet::Lookup).to receive(:new).and_return(lookup)
      allow(lookup).to receive(:street=)
      allow(lookup).to receive(:city=)
      allow(lookup).to receive(:zipcode=)
      allow(lookup).to receive(:candidates=)
      allow(lookup).to receive(:match=)
      allow(client).to receive(:send_lookup)
      allow(lookup).to receive(:result).and_return(result)
      allow(Helper).to receive(:print_address)
    end

    context 'when address is valid' do
      let(:address) { addresses.first }
      let(:best_match) { instance_double(SmartyStreets::USStreet::Candidate) }
      let(:output) { '143 e Main Street, Columbus, 43215 -> 143 E Main St, Columbus, 43215-5370' }

      before do
        allow(result).to receive(:[]).with(0).and_return(best_match)
        allow(Helper).to receive(:print_address).with(best_match).and_return('143 E Main St, Columbus, 43215-5370')
      end

      it 'returns the correct result' do
        expect(subject.run).to eq([output])
      end

      it 'sends the lookup request to the client' do
        expect(client).to receive(:send_lookup).with(lookup)
        subject.run
      end
    end

    context 'when address is invalid' do
      let(:address) { address.first }
      
      let(:output) { "143 e Main Street, Columbus, 43215 -> Invalid Address" }

      before do
        allow(result).to receive(:[]).with(0).and_return(nil)
        expect(client).to receive(:send_lookup).with(lookup)
      end

      it 'returns the correct result' do
        allow(client).to receive(:send_lookup).and_return(nil)
        expect(subject.run).to eq([output])
      end

      it 'handles the error gracefully' do
        expect { subject.run }.not_to raise_error
      end
    end
  end
end