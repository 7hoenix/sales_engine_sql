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
    #temp = find_all_by_temp(x, match)
    return_records = records.select do |record|
      match == record.send(x).to_s.downcase
    end
    return_records

    #raise "boom" if !return_records.empty? && return_records == temp
  end

  def find_all_by_temp(x, match)
    records = database.execute( "SELECT * FROM #{table} WHERE #{x}=#{match};" )
    new_records = records.map do |record|
      thing = create_record(record)
    end
    new_records
  end

  def all
    records
  end

  def random
    records.sample
  end
end
