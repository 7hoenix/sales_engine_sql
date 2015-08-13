require_relative '../modules/record_like.rb'
require_relative '../modules/good_date.rb'
require 'bigdecimal'

class InvoiceItem
  include RecordLike
  include GoodDate

  attr_accessor :item_id, :invoice_id, :quantity , :unit_price, :created_at,
    :updated_at, :cached_invoice, :cached_item, :cached_price
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id] || record["id"]
    @item_id     = record[:item_id] || record["item_id"]
    @invoice_id  = record[:invoice_id] || record["invoice_id"]
    @quantity    = record[:quantity] || record["quantity"]
    if record['unit_price'].nil?
      @unit_price = BigDecimal.new(record[:unit_price])/100
    else
      @unit_price = BigDecimal.new(record["unit_price"])/100
    end
    @created_at  = record[:created_at] || record["created_at"]
    @updated_at  = record[:updated_at] || record["updated_at"]
    @repository  = record.fetch(:repository, nil)
  end

  def invoice
    rows = repository.database.query( "SELECT * FROM invoices WHERE invoices.id =
      '#{invoice_id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.invoice_repository.create_record(row) }.first
  end

  def item
    rows = repository.database.query( "SELECT * FROM items WHERE items.id =
      '#{item_id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.item_repository.create_record(row) }.first
  end

  def total_price
    cached_price ||= quantity * unit_price
  end

end
