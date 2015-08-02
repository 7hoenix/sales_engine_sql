require 'set'
require_relative '../modules/record_like'
require_relative '../modules/relationship'

class Merchant
  include RecordLike
  include Relationships

  attr_accessor :name, :created_at , :updated_at
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id]
    @name        = record[:name]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
    @repository  = record.fetch(:repository, nil)
  end

  def items
    repository.get(__callee__, id, :merchant_id)
  end

  def invoices
    repository.get(__callee__, id, :merchant_id)
  end

  def invoices_for(date)
    if date == "all"
      invoices
    else
      invoices.select do |invoice|
        invoice.created_at.to_date == DateTime.parse(date).to_date
      end
    end
  end

  def invoice_items_for(date)
    invoice_items(invoices_for(date))
  end

  def invoice_items(invoices)
    invoices.map do |invoice|
      repository.get(__callee__, invoice.id, :invoice_id)
    end.flatten
  end

  def paid_invoice_items_for(date = "all")
    invoice_items_for(date).reject do |ii|
      zero_revenue_invoices.include?(ii.invoice_id)
    end
  end

  def revenue(date = "all")
    cents = paid_invoice_items_for(date).reduce(0) do |acc, ii|
      acc + ii.total_price
    end
    to_dollars(cents)
  end

  def transactions
    invoices.map do |invoice|
      repository.get(__callee__, invoice.id, :invoice_id)
    end.flatten
  end

  def transactions_by_invoice_id
    transactions.group_by do |transaction|
      transaction.invoice_id
    end
  end

  def paid_invoices
    Set.new(invoices) - Set.new(zero_revenue_invoices)
  end

  def zero_revenue_invoices
    transactions_by_invoice_id.each_with_object([]) do |(key, values), failures|
      failures << key if values.all? {|charge| charge.result == "failed"}
    end
  end

  def favorite_customer


  end
end