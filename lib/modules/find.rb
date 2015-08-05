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
    match = match.to_s.downcase
    found = @records.select do |id, record|
      match == record.send(x).to_s.downcase
    end
    objects(found.to_a)
  end

  def objects(hashed)
    hashed.each_with_object([]) do |(id, record), array|
      array << record
    end
  end

  def all
    objects(records)
  end
  
  def random
    records.values.sample
  end
end