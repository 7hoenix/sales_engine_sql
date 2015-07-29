require_relative '../lib/loader.rb'
require_relative '../lib/merchant.rb'

class MerchantRepository
  attr_accessor :merchants
  def initialize(filename='./data/merchants.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @merchants = populate_merchants(loaded_csvs)
  end

  def add_merchant(record)
    Merchant.new(record)
  end

  def populate_merchants(loaded_csvs)
    merchants = {}
    loaded_csvs.each do |merchant|
      id = merchant.first
      record = merchant.last
      merchants[id] = add_merchant(record)
    end
    merchants
  end

end