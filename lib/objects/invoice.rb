require_relative '../modules/record_like.rb'

class Invoice
  include RecordLike

  attr_accessor :customer_id, :merchant_id, :status , :created_at,
    :updated_at, :cached_transactions, :cached_invoice_items, :cached_items,
    :cached_customer, :cached_merchant
  attr_reader :id, :repository

  def initialize(record)
    @id = record[:id] || record["id"]
    @customer_id = record[:customer_id] || record["customer_id"]
    @merchant_id = record[:merchant_id] || record["merchant_id"]
    @status      = record[:status] || record["status"]
    @created_at  = record[:created_at] || record["created_at"]
    @updated_at  = record[:updated_at] || record["updated_at"]
    @repository  = record.fetch(:repository, nil)
  end

  def transactions
    rows = repository.database.query( "SELECT * FROM transactions WHERE invoice_id = '#{id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.transaction_repository.create_record(row) }
  end

  def invoice_items
    rows = repository.database.query( "SELECT * FROM invoice_items WHERE invoice_id = '#{id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.invoice_item_repository.create_record(row) }
  end

  def items
    rows = repository.database.query(
      "SELECT * FROM items, invoice_items, invoices
       WHERE invoices.id = '#{id}'
       AND invoice_items.invoice_id = invoices.id
       AND items.id = invoice_items.item_id" )
    rows.to_a.flat_map { |row| repository.engine.item_repository.create_record(row) }
  end

  def customer
    rows = repository.database.query( "SELECT * FROM customers WHERE customers.id = '#{customer_id}' " )
    rows.to_a.flat_map { |row|
      repository.engine.customer_repository.create_record(row) }.first
  end

  def merchant
    rows = repository.database.query( "SELECT * FROM merchants WHERE
      merchants.id = '#{merchant_id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.merchant_repository.create_record(row) }.first
  end

  def paid?
    transactions.any? {|transaction| transaction.successful?}
  end

  def total_billed
    invoice_items.reduce(0) do |acc, ii|
      acc + ii.total_price
    end
  end

  def add_items(items)
    repository.add_items(items, self)
  end

  def charge(args)
    repository.charge(args, self)
  end
end
