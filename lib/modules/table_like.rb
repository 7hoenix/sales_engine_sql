module TableLike
  def build_from(loaded_csvs)
    self.records = {}
    loaded_csvs.each do |row|
      id = row.first
      record = row.last
      record[:repository] = self
      self.records[id] = create_record(record)
    end
    records
  end
end