require 'csv'

class Loader
  def initialize
  end

  def load_csv(str)
    records  = {}
    args = {:headers => true,
            :header_converters => :symbol,
            :converters => :all}
    CSV.foreach(str, args) do |row|
        records[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
    end
    records
  end

end