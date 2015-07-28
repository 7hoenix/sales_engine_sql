require_relative '../lib/merchant_repository'

class SalesEngine
  attr_accessor :merchant_repository
  def initialize
  end
  def startup
    @merchant_repository = MerchantRepository.new
  end
end

if __FILE__  == $0
  engine = SalesEngine.new
  engine.startup


end
