require 'pry'
require_relative '../loader'
require_relative '../objects/transaction'
require_relative '../modules/table_like'

class TransactionRepository
  include TableLike

  attr_accessor :records
  attr_reader :engine

  def initialize(args)
    filename = args.fetch(:filename, 'transactions.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @records = build_from(loaded_csvs)
    @engine = args.fetch(:engine, nil)
  end

  def create_record(record)
    Transaction.new(record)
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