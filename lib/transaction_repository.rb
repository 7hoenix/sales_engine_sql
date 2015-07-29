require 'pry'
require_relative '../lib/loader.rb'
require_relative '../lib/transaction'

class TransactionRepository
  attr_accessor :transactions
  def initialize(filename='./data/transactions.csv')
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
      transactions[id] = add_transaction(record)
    end
    transactions
  end

end