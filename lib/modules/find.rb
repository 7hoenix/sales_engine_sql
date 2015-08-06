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
    # found = @records.select do |id, record|
    found = @records.select do |record|
      match == record.send(x).to_s.downcase
      # match == record.send(x).to_s.downcase
    end
    found
    # objects(found.to_a)
  end

  def objects(data)
    # hashed.each_with_object([]) do |(id, record), array|
    #   array << record
    # end
    data
  end

  def all
    objects(records)
  end

  def random
    records.sample
  end
end