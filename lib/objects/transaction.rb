require_relative '../modules/record_like.rb'

class Transaction
  include RecordLike

  attr_accessor :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result, :created_at, :updated_at,
                :cached_invoice
  attr_reader :id, :repository

  def initialize(record)
    @id                           = record[:id] || record["id"]
    @invoice_id                   = record[:invoice_id] || record["invoice_id"]
    @credit_card_number           = record[:credit_card_number] || record["credit_card_number"]
    @credit_card_expiration_date  = record[:credit_card_expiration_date] || record["credit_card_expiration_date"]
    @result                       = record[:result] || record["result"]
    @created_at                   = record[:created_at] || record["created_at"]
    @updated_at                   = record[:updated_at] || record["updated_at"]
    @repository                   = record.fetch(:repository, nil)
  end

  def invoice
    rows = repository.database.query( "SELECT * FROM invoices WHERE transactions.invoice_id =
      '#{invoice_id}'" )
    rows.to_a.flat_map { |row|
      repository.engine.invoice_repository.create_record(row) }.first
  end

  def invoice
    cached_invoice ||= repository.get_invoice_for(self).reduce
  end

  def successful?
    result == "success"
  end

end
