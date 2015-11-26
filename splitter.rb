require 'csv'

class Splitter

  def initialize( primary_csv, secondary_csv, new_csv )
    @new_csv        = new_csv
    @primary_data   = read_data_from( primary_csv )
    @secondary_data = read_data_from( secondary_csv )

    calculate_new_data
    write_to_new_file
  end

  def calculate_new_data
    @new_data = @primary_data - @secondary_data
  end

  def read_data_from( csv_file )
    data = []

    CSV.foreach( csv_file, { headers: true } ) do |row|
      data << row[0]
    end

    return data
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
