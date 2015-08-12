require 'pry'
require_relative '../loader'
require_relative '../objects/transaction'
require_relative '../modules/table_like'

class TransactionRepository
  include TableLike

  attr_accessor :records, :cached_invoices, :database
  attr_reader :engine, :table

  def initialize(args)
    filename = args.fetch(:filename, 'transactions.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @database = args.fetch(:database, nil)

      create_transaction_table
      build_for_database(loaded_csvs)
      @new_records ||= table_records

    @records = build_from(loaded_csvs)
    @table = "transactions"
    @engine = args.fetch(:engine, nil)
  end

  def create_transaction_table
    database.execute( "CREATE TABLE transactions(id INTEGER PRIMARY KEY
                      AUTOINCREMENT, invoice_id INTEGER, credit_card_number
                      INTEGER, credit_card_expiration_date DATE, result
                      VARCHAR(31), created_at DATE, updated_at DATE)" );
  end

  def add_record_to_database(record)
    database.execute( "INSERT INTO transactions(invoice_id, credit_card_number,
                      credit_card_expiration_date, result, created_at,
                      updated_at) VALUES ('#{record[:invoice_id]}',
                      '#{record[:credit_card_number]}',
                      '#{record[:credit_card_expiration_date]}',
                      '#{record[:status]}',
                      #{record[:created_at].to_date},
                      #{record[:updated_at].to_date});" )
  end

  def create_record(record)
    Transaction.new(record)
  end

  def table_records
    database.execute( "SELECT * FROM transactions" ).map { |row| Transaction.new(row) }
  end

  def get_invoice_for(transaction)
    invoices.select do |invoice|
      invoice.id == transaction.invoice_id
    end.flatten
  end

  def invoices
    cached_invoices ||= begin
      args = {:repo => :invoice_repository,
                :use => :all}
      engine.get(args)
    end
  end

  def count
    all.count{|trans| trans.successful?}
  end

  def charge(args, invoice)
    record = args
    record[:invoice_id] = invoice
    record[:id] = next_id
    record[:result] = args[:result]
    record[:created_at] = timestamp
    record[:updated_at] = timestamp
    records << create_record(record)
  end
end
