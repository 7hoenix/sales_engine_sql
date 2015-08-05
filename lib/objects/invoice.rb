require_relative '../modules/record_like.rb'

class Invoice
  include RecordLike

  attr_accessor :customer_id, :merchant_id, :status , :created_at, :updated_at
  attr_reader :id, :repository

  def initialize(record)
    @id = record[:id]
    @customer_id = record[:customer_id]
    @merchant_id = record[:merchant_id]
    @status      = record[:status]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
    @repository  = record.fetch(:repository, nil)
  end

  def transactions
    repository.get(:transactions, id, :invoice_id)
  end

  def invoice_items
    repository.get(:invoice_items, id, :invoice_id)
  end

  def items
    invoice_items.map{|ii| repository.get(:items, ii.item_id, :id)}.flatten
  end

  def customer
    repository.get(:customer, customer_id, :id).reduce
  end

  def merchant
    repository.get(:merchant, merchant_id, :id).reduce
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