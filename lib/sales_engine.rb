require_relative './repos/merchant_repository'
require_relative './repos/invoice_repository'
require_relative './repos/item_repository'
require_relative './repos/invoice_item_repository'
require_relative './repos/customer_repository'
require_relative './repos/transaction_repository'


class SalesEngine
  attr_accessor :merchant_repository
  def initialize
  end

  def startup
    @merchant_repository = MerchantRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @item_repository = ItemRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @customer_repository = CustomerRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
  end

end

if __FILE__  == $0
  engine = SalesEngine.new
  puts "engine starting up..."
  engine.startup
  puts "Done."


end

