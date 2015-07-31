require_relative '../modules/relationship'
class Merchant
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

end