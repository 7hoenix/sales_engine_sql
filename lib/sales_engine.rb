require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'


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
