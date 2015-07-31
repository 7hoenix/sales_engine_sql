require 'pry'
module Find

  def find_by(x, match)
    found = find_all_by(x, match)
    if found.first.nil?
      false
    else
      found[0]
    end
  end
  def find_all_by(x, match)
    x = x.to_sym
    match = match.to_s.downcase
    if @records[1].respond_to?(x)
      found = @records.select do |id, record|
        match == record.send(x).to_s.downcase
      end
      return found.to_a
    else
      []
    end
  end  

  # def objects(data)
  #   data.map do |row|
  #     row[:repository] = self
  #     holds_type.new(row)
  #   end
  # end

  # def find_prefix
  #   "find_by_".length
  # end

  # def find_all_prefix
  #   "find_all_by_".length
  # end




end