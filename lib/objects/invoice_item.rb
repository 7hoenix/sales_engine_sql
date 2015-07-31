class InvoiceItem
  attr_accessor :item_id, :invoice_id,
                :quantity , :unit_price,
                :created_at, :updated_at
  attr_reader :id, :repository

  def initialize(record)
    @id          = record[:id]
    @item_id     = record[:item_id]
    @invoice_id  = record[:invoice_id]
    @quantity    = record[:quantity]
    @unit_price  = record[:unit_price]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
    @repository  = record.fetch(:repository, nil)

  end

end