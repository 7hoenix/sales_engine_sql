class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :merchant_id,
                :created_at,
                :updated_at
  attr_reader :id

  def initialize(record)
    @id          = record[:id]
    @name        = record[:name]
    @description = record[:description]
    @unit_price  = record[:unit_price]
    @merchant_id = record[:merchant_id]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
    @repository  = record.fetch(:repository, nil)
  end

end