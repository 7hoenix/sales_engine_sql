require_relative 'find'
require_relative 'find_by_x'
# require_relative 'list'

module TableLike
  # include List
  include Find
  include FindByX

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

  def get(what, source_key_value, remote_key_name)
    foreign_repo = repo_map[what.to_sym]
    engine.send(foreign_repo).find_all_by(remote_key_name, source_key_value)
  end

  # factored out of get.. not yet retested/used
  def foreign_key_for(repo, class_name)
    engine.send(repo).holds_type.foreign_keys[class_name]
  end

  def repo_map
    {
      :item => :item_repository,
      :items => :item_repository,
      :invoice => :invoice_repository,
      :invoices => :invoice_repository,
      :transactions => :transaction_repository,
      :invoice_items => :invoice_item_repository,
      :customer => :customer_repository,
      :merchant => :merchant_repository,
      :paid_invoices => :invoice_repository, #not yet used
      :paid_invoice_items => :invoice_item_repository
    }
  end

  def to_dollars(cents)
    cents.round(2)
  end

  def inspect
    "#<#{self.class} #{@records.size} rows>"
  end

  def timestamp
    Time.now.utc.to_s
  end

  def next_id
    all.last.id + 1
  end
end