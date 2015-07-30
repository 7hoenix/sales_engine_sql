require_relative '../modules/relationship'
class Merchant
  attr_accessor :name, :created_at , :updated_at
  include Relationships
  def initialize(record)
    @name = record[:name]
    @created_at = record[:created_at]
    @updated_at = record[:updated_at]
  end

end