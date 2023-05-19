require 'json'
require 'net/http'
require './helper.rb'
require 'smartystreets_ruby_sdk/client_builder'                                                     
require 'smartystreets_ruby_sdk/static_credentials'                                                 
require 'smartystreets_ruby_sdk/us_street'    

class AddressValidator
    
    def initialize(client, addresses)
        @client = client
        @addresses = addresses    
    end    

    def run
        results = []
        @addresses.each do |address|
            address_details = SmartyStreets::USStreet::Lookup.new
            output =  "#{address['Street']}, #{address['City']}, #{address['Zip Code']} -> "

            address_details.street = address['Street']
            address_details.city = address['City']
            address_details.zipcode = address['Zip Code']
            address_details.candidates = 1
            address_details.match = SmartyStreets::USStreet::MatchType::STRICT
            
            begin
               
                @client.send_lookup(address_details)

                result = address_details.result
                best_match = result[0]
            
                if best_match
                    output += Helper.print_address(best_match)
                    
                else
                    output += 'Invalid Address'
                end
                 
                results << output
            rescue SmartyStreets::SmartyError => err
                output += 'Invalid Address'
                results << output
            end   
        end
        results    
    end
end

