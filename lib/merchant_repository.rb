require_relative '../lib/loader.rb'
require_relative '../lib/merchant.rb'

class MerchantRepository
  attr_accessor :merchants
  def initialize(filename='./data/merchants.csv')
    @loader = Loader.new
    @merchants = {}
    hash = @loader.load_csv(filename)
    populate_merchants(hash)
  end
  def add_merchant(record)
    Merchant.new(record)
  end
  def populate_merchants(hash)
    hash.each do |merchant|
      id = merchant[0]
      record = merchant[1]
      @merchants[id] = add_merchant(record)
    end
  end

end