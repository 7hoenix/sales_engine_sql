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

  def paid_invoices
    invoices.select{|invoice| invoice.paid?}
    # (&:paid?)
  end

  def paid_invoices_for(date)
    if date == "all"
      paid_invoices
    else
      paid_invoices.select do |invoice|
        invoice.created_at.to_date == DateTime.parse(date).to_date
      end
    end
  end

  def invoice_items_for(date)
    invoice_items(invoices_for(date))
  end

  def invoice_items(invoices)
    invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def paid_invoice_items_for(date = "all")
    invoice_items(paid_invoices_for(date))
  end

  def revenue(date = "all")
    cents = paid_invoice_items_for(date).reduce(0) do |acc, ii|
      acc + ii.total_price
    end
    to_dollars(cents)
  end

  def favorite_customer
    #assumes at most one successful transaction per invoice
    by_cust_id = paid_invoices.group_by{|invoice| invoice.customer_id}
    by_cust_id.max_by do |id, invoices| 
      invoices.inject(0) do |acc, invoice|
      end
    end
  end
end