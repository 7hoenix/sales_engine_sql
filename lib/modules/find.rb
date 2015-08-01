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
    x = x.to_sym if x.class != Symbol
    match = match.to_s.downcase
    if @records[1].respond_to?(x)
      found = @records.select do |id, record|
        match == record.send(x).to_s.downcase
      end
      return objects(found.to_a)
    else
      []
    end
  end

  def objects(hashed)
    hashed.each_with_object([]) do |(id, record), array|
      array << record
    end
  end

end