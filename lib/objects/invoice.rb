class Invoice
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

end