require 'pry'
module Find

  def find_by(x, match)
    if @records[1].respond_to?(x)
      found = @records.select do |id, record|
        match ==  record.send(x)
      end
      return found.to_a
    else
      "not a valid column"
    end
  end
end