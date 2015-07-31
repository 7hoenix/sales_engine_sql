require 'pry'
require_relative '../loader.rb'
require_relative '../objects/transaction.rb'
require_relative '../modules/util'

class TransactionRepository
  include Util

  attr_accessor :transactions
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, './data/fixtures/transactions.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @transactions = populate_transactions(loaded_csvs)
  end

  def add_transaction(record)
    Transaction.new(record)
  end

  def populate_transactions(loaded_csvs)
    transactions = {}
    loaded_csvs.each do |transaction|
      id = transaction.first
      record = transaction.last
      record[:repository] = self
      transactions[id] = add_transaction(record)
    end
    transactions
  end

end