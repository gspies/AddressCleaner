module Helper
    def self.print_address(address_obj)
        full_address = address_obj.delivery_line_1 + ", "  + address_obj.components.city_name + ", " + address_obj.components.zipcode
       
        if address_obj.components.plus4_code
            full_address += '-' + address_obj.components.plus4_code
        end
    
        full_address
    end    
end