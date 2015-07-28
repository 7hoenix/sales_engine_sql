require_relative '../lib/merchant_repository'

class SalesEngine
  attr_accessor :merchant_repository
  def initialize
    @loadcsv = "hi"
    @merchant_repository = MerchantRepository.new
  end
  def startup
    true
    # @customer_repository = CustomerRepository.new
  end
end

if __FILE__  == $0
  engine = SalesEngine.new
  engine.startup
  

end
