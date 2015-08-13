require_relative '../modules/record_like.rb'
require 'bigdecimal'
require 'date'

class Item
  include RecordLike

  attr_accessor :name, :description, :unit_price, :merchant_id,
    :created_at, :updated_at, :cached_invoices, :cached_paid_invoices,
    :cached_unpaid_invoices, :cached_invoice_items, :cached_merchant,
    :cached_paid_invoice_items
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id] || record["id"]
    @name        = record[:name] || record["name"]
    @description = record[:description] || record["description"]
    if record['unit_price'].nil?
      @unit_price = BigDecimal.new(record[:unit_price])/100
    else
      @unit_price = BigDecimal.new(record["unit_price"])/100
    end
    @merchant_id = record[:merchant_id] || record["merchant_id"]
    @created_at  = record[:created_at] || record["created_at"]
    @updated_at  = record[:updated_at] || record["updated_at"]
    @repository  = record.fetch(:repository, nil)
  end

  def invoice_items
    cached_invoice_items ||= repository.get(:invoice_items, id, :item_id)
  end

  def paid_invoice_items
    cached_paid_invoice_items ||= repository.paid_invoice_items(self)
  end

  def unpaid_invoices
    cached_unpaid_invoices ||= invoices.reject(&:paid?)
  end

  def paid_invoices
    cached_paid_invoices ||= repository.paid_invoices(self)
  end

  def invoice_items_for(invoice_date)
    if invoice_date == "all"
      invoice_items
    else
      invoice_items.select do |ii|
        ii.invoice.created_at.to_date == invoice_date.to_date
      end
    end
  end

  def merchant
    cached_merchant ||= repository.get(:merchant, merchant_id, :id).reduce
  end

  def invoices
    cached_invoices ||= invoice_items.map{|ii| ii.invoice}
  end

  def paid_invoices_for(date)
    if date == "all"
      paid_invoices
    else
      paid_invoices.select do |invoice|
        invoice.created_at.to_date == date.to_date
      end
    end
  end

  def paid_invoice_items_for(date)
    if date == "all"
      paid_invoice_items
    else
      paid_invoice_items.select do |ii|
        ii.invoice.created_at == date
      end
    end
  end

  def revenue(date = "all")
    paid_invoice_items_for(date).reduce(0) do |acc, ii|
      acc + ii.total_price
    end
  end

  def quantity_sold(date = "all")
    paid_invoice_items_for(date).reduce(0) do |acc, ii|
      acc + ii.quantity
    end
  end

  def dates_sold
    paid_invoices.map{|invoice| invoice.created_at }.uniq
  end

  def best_day
    if dates_sold.empty?
      nil
    else
      best_day = dates_sold.max_by{|date| revenue(date) }
      Date.parse(best_day)
    end
  end

end
