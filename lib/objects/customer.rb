require_relative '../modules/record_like.rb'

class Customer
  include RecordLike

  attr_accessor :first_name, :last_name, :created_at, :updated_at,
    :cached_invoices, :cached_paid_invoices, :cached_transactions
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id]
    @first_name  = record[:first_name]
    @last_name   = record[:last_name]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
    @repository  = record.fetch(:repository, nil)
  end

  def invoices
    cached_invoices ||= repository.invoices(self)
  end

  def paid_invoices
    cached_paid_invoices ||= invoices.select{|invoice| invoice.paid?}
  end

  def transactions
    cached_transactions ||= invoices.map {|invoice| invoice.transactions}.flatten
  end

  def merchants_from_paid_invoices
    paid_invoices.map {|invoice| invoice.merchant }
  end

  def favorite_merchant
    merchants = paid_invoices.group_by{|invoice| invoice.merchant}
    merchants.max_by do |id, invoices|
      invoices.length
    end.first
  end
end