require 'set'
require_relative '../modules/record_like'

class Merchant
  include RecordLike

  attr_accessor :name, :created_at , :updated_at, :cached_items,
  :cached_invoices, :cached_paid_invoices, :cached_unpaid_invoices
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id] || record["id"]
    @name        = record[:name] || record["name"]
    @created_at  = record[:created_at] || record["created_at"]
    @updated_at  = record[:updated_at] || record["updated_at"]
    @repository  = record.fetch(:repository, nil)
  end

  def items
    rows = repository.database.query( "SELECT * FROM items WHERE merchant_id = '#{id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.item_repository.create_record(row) }
  end

  def invoices
    rows = repository.database.query( "SELECT * FROM invoices WHERE merchant_id
      = '#{id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.invoice_repository.create_record(row) }
  end

  def invoices_for(date)
    if date == "all"
      invoices
    else
      invoices.select do |invoice|
        invoice.created_at.to_date == date.to_date
      end
    end
  end

  def paid_invoices
    cached_paid_invoices ||= repository.paid_invoices(self)
  end

  def unpaid_invoices
    cached_unpaid_invoices ||= repository.unpaid_invoices(self)
  end

  def paid_invoices_for(date)
    if date == "all"
      paid_invoices
    else
      paid_invoices.select do |invoice|
        invoice.created_at == date.to_date
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

 # def revenue
 #   rows = repository.database.query( "SELECT * FROM invoice_items,
 #     transactions, invoices, merchants WHERE merchants.id = '#{id}' AND
 #     transactions.invoice_id = invoice_id AND transactions.result = 'success' AND invoice.id = invoice_items.invoice_id" )
 #   rows.to_a.flatten.reduce(0) { |row| row.quantity * row.unit_price }
 # end

 def revenue(dates = "all")
   if dates == "all"
     revenue_all
   else
     dates = dates..dates if !(dates.is_a?(Range))
     revenue_range(dates)
   end
 end

  def revenue_day(date)
    paid_invoices_for(date).reduce(0) do |acc, invoice|
      acc + invoice.total_billed
    end
  end

  def revenue_range(dates)
    dates.map {|date| revenue_day(date)}.reduce(:+)
  end

  def revenue_all
    paid_invoices_for("all").reduce(0) do |acc, invoice|
      acc + invoice.total_billed
    end
  end

  def favorite_customer
    customers = paid_invoices.group_by{|invoice| invoice.customer}
    customers.max_by do |id, invoices|
      invoices.length
    end.first
  end

  def customers_with_pending_invoices
    customers = unpaid_invoices.map{|invoice| invoice.customer}.uniq
  end
end
