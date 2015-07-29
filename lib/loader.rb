require 'csv'

class Loader

  def load_csv(str)
    records  = {}
    args = {:headers => true,
            :header_converters => :symbol,
            :converters => :all}
    CSV.foreach(str, args) do |row|
        id = row.fields[0]
        headers = row.headers[1..-1]
        fields = row.fields[1..-1]
        records[id] = Hash[headers.zip(fields)]
    end
    records
  end

end