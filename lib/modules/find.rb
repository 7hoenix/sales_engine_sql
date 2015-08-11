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
    temp = find_all_by_temp(x, match) if !database.nil?
    return_records = records.select do |record|
      match == record.send(x).to_s.downcase
    end
    raise "boom" if !return_records.empty? && return_records == temp
    return_records
  end

  def find_all_by_temp(x, match)
    database.execute( "SELECT * FROM #{table} WHERE #{x}=#{match};" )
  end

  def all
    records
  end

  def random
    records.sample
  end
end
