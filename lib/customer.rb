class Customer
  attr_accessor :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(record)
    @first_name  = record[:first_name]
    @last_name  = record[:last_name]
    @created_at  = record[:created_at]
    @updated_at  = record[:updated_at]
  end

end