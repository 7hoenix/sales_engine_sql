require_relative './list'
require_relative './find'
require_relative './find_by_x.rb'

module Util
  include List
  include Find
  include FindByX

  def record_type(records)
    @records
  end

  def record_type=(records)
    @records = records
  end

  def records
    @records
  end

  def records=(records)
    @records = records
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
      :merchant => :merchant_repository
    }
  end

  def to_dollars(cents)
    (cents / 100).round(2)
  end

  # def inspect
  #   self.object_id
  # end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end