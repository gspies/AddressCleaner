require './csv_reader'
require './address_validator'
require 'smartystreets_ruby_sdk/client_builder'                                                     
require 'smartystreets_ruby_sdk/static_credentials'                                                 
require 'smartystreets_ruby_sdk/us_street'   

class AddressCleaner
    API_KEY = 'YOUR_API_KEY'
    AUTH_ID = 'YOUR_AUTH_ID'

    def self.run
        client = create_client
        csv_reader = CSVReader.new('../input.csv')
        addresses = csv_reader.read_csv
        
        validator = AddressValidator.new(client, addresses)
        corrected_addresses = validator.run

        corrected_addresses.each do  |address|
            puts address 
        end    
    end    

    def self.create_client
        credentials = SmartyStreets::StaticCredentials.new(AUTH_ID, API_KEY)    
        client = SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client     
    end
end


AddressCleaner.run