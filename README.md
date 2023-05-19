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
