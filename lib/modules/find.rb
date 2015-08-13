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
    records = database.query( "SELECT * FROM #{table} WHERE #{x}='#{match}'" )
    records.map do |record|
      create_record(record)
    end
  end

  def all
    records = database.query( "SELECT * FROM #{table}" )
    records.map { |record| create_record(record) }
  end

  def random
    records.sample
  end
end
