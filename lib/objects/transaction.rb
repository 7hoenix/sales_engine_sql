class Transaction
  attr_accessor :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result, :created_at, :updated_at
  attr_reader :id

  def initialize(record)
    @id                           = record[:id]
    @invoice_id                   = record[:invoice_id]
    @credit_card_number           = record[:credit_card_number]
    @credit_card_expiration_date  = record[:credit_card_expiration_date]
    @result                       = record[:result]
    @created_at                   = record[:created_at]
    @updated_at                   = record[:updated_at]
    @repository                   = record.fetch(:repository, nil)
  end

end