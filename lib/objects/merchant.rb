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

  def invoice_items
    invoices.map do |invoice|
      repository.get(__callee__, invoice.id, :invoice_id)
    end.flatten
  end

  def revenue
    invoice_items.reduce(0) do |acc, ii|
      acc + ii.total_price
    end
  end
end