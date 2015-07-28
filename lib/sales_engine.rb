

class SalesEngine
  attr_accessor :customer_repository
  def initialize
    @loadcsv = "hi"
  end
  def startup
    @customer_repository = CustomerRepository.new
  end
end

if __FILE__  == $0

end
