# Address Cleaner

A small command line application that will take in an input file containing a street, city, and zipcode, and print out the corrected address. 

## Getting Started

Clone the repository by running `git clone git@github.com:gspies/AddressCleaner.git`.

Once you are in the root directory of the repository, run `bundle install` to install the gems specified in the `Gemfile`.

To setup the Smarty API, open the `src/address_cleaner.rb` add your personal `API key and Auth ID` respectively on lines 8 and 9.

To clean the desired addresses, you can add new lines containing the new addresses in the format specified in the `input.csv` file.

## Usage
To run the script, first change to the `src` directory by running `cd src`.

After you are in the `src` directory, you can run `ruby ./address_cleaner.rb` in order to clean the addresses provided in the input file.

### Testing
You can run the unit test suite when you are in the `src` directory, by running the `bundle exec rspec ../spec/.` command.
This will run all of the spec files in the `spec` directory, and will print the results in the console.

## Design
I went with a three class approach for this solution in order to reduce coupling and split up the responsibilties. 

The CSVReader class handles reading the input, and returning the addresses as an array to be used in the AddressValidator class. 

The AddressValidator class takes in the Smarty client from the smartystreets_ruby_sdk gem and the array of addresses. This class performs a lookup for each address, calling the Smarty API to get a response containing the cleaned address, or containing an empty array if the address is invalid. The AddressValidator then calls the Helper module to format the address and returns the formatted addresses in an array.

The AddressCleaner class is the glue that holds the rest of the classes together. The AddressCleaner starts by creating a Smarty API client, creating a CSVReader class to read the input file, and pass both the client and the addresses to the AddressValidator class. The AddressCleaner then prints the correctly formatted addresses to standard output.
