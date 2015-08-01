require_relative '../modules/record_like.rb'

class Customer
  include RecordLike

  attr_accessor :first_name,
                :last_name,
                :created_at,
                :updated_at
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
    repository.get(__callee__, self.id, :customer_id)
  end

end