module Find
  def find_by(x, match)
    found = find_all_by(x, match)
    if found.first.nil?
      false
    else
      found[0]
    end
  end

  def find_all_by_old(x, match)
    match = match.to_s.downcase
    #temp = find_all_by_temp(x, match)
    return_records = records.select do |record|
      match == record.send(x).to_s.downcase
    end
    return_records

    #raise "boom" if !return_records.empty? && return_records == temp
  end

  def find_all_by(x, match)
    records = database.query( "SELECT * FROM #{table} WHERE #{x}='#{match}'" )
    records.map do |record|
      create_record(record)
    end
  end

  def all
    records
  end

  def random
    records.sample
  end
end
