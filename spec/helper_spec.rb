require '../src/helper.rb'

RSpec.describe Helper do
  describe '.print_address' do
    it 'returns the formatted address' do
      address_obj = double('Address')
      allow(address_obj).to receive_message_chain('delivery_line_1').and_return('123 Main St')
      allow(address_obj).to receive_message_chain('components.city_name').and_return('City')
      allow(address_obj).to receive_message_chain('components.zipcode').and_return('12345')
      allow(address_obj).to receive_message_chain('components.plus4_code').and_return(nil)

      formatted_address = Helper.print_address(address_obj)
      expect(formatted_address).to eq('123 Main St, City, 12345')
    end

    it 'returns the formatted address with plus4 code' do
      address_obj = double('Address')
      allow(address_obj).to receive_message_chain('delivery_line_1').and_return('456 Elm St')
      allow(address_obj).to receive_message_chain('components.city_name').and_return('City')
      allow(address_obj).to receive_message_chain('components.zipcode').and_return('67890')
      allow(address_obj).to receive_message_chain('components.plus4_code').and_return('1234')

      formatted_address = Helper.print_address(address_obj)
      expect(formatted_address).to eq('456 Elm St, City, 67890-1234')
    end
  end
end
