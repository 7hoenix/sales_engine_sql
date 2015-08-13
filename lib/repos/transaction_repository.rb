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
      @records ||= table_records

    #@records = build_from(loaded_csvs)
    @table = "transactions"
    @engine = args.fetch(:engine, nil)
  end

  def create_transaction_table
    database.execute( "CREATE TABLE transactions(id INTEGER PRIMARY KEY,
                      invoice_id INTEGER, credit_card_number INTEGER,
                      credit_card_expiration_date DATE, result VARCHAR(31),
                      created_at DATE, updated_at DATE)" );
  end

  def add_record_to_database(record)
    new_record = [record[:id],
                  record[:invoice_id],
                  record[:credit_card_number],
                  record[:credit_card_expiration_date],
                  record[:result],
                  record[:created_at],
                  record[:updated_at]]
    prepped = database.prepare( "INSERT INTO transactions(id, invoice_id,
                                credit_card_number, credit_card_expiration_date,
                                result, created_at, updated_at)
                                VALUES (?,?,?,?,?,?,?)" )
    prepped.execute(new_record)
  end

  def create_record(record)
    record[:repository] = self
    Transaction.new(record)
  end

  def table_records
    database.execute( "SELECT * FROM transactions" ).map do |row|
      row[:repository] = self
      Transaction.new(row)
    end
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
    add_record_to_database(record)
  end
end
