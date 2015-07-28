class Merchant
  attr_accessor :id, :name, :created_at , :updated_at
  def initialize(record)
    @id = record[:id]
    @name = record[:name]
    @created_at = record[:created_at]
    @updated_at = record[:updated_at]
  end

end