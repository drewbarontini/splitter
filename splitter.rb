require 'csv'

class Splitter

  def initialize primary_csv, secondary_csv, new_csv
    @primary_csv   = primary_csv
    @secondary_csv = secondary_csv
    @new_csv       = new_csv

    @primary_data   = []
    @secondary_data = []
    @new_data       = []

    read_data_from_files
    run_comparison
  end

  def read_data_from_files
    CSV.foreach( @primary_csv ) do |row|
      @primary_data << row[0] unless row[0] == 'Email'
    end

    CSV.foreach( @secondary_csv ) do |row|
      @secondary_data << row[0] unless row[0] == 'Email'
    end
  end

  def run_comparison
    @new_data = @primary_data - @secondary_data
    write_to_new_file
  end

  def write_to_new_file
    CSV.open( @new_csv, 'w', write_headers: true, headers: [ 'Email' ] ) do |row|
      @new_data.each do |data|
        row << [data]
      end
    end
  end

end

Splitter.new 'primary.csv', 'secondary.csv', 'new.csv'
