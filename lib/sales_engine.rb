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
    @merchant_repository = MerchantRepository.new
    @invoice_repository = InvoiceRepository.new
    @item_repository = ItemRepository.new
    @invoice_item_repository = InvoiceItemRepository.new
    @customer_repository = CustomerRepository.new
    @transaction_repository = TransactionRepository.new
  end



end

if __FILE__  == $0
  engine = SalesEngine.new
  puts "engine starting up..."
  engine.startup
  puts "Done."


end

