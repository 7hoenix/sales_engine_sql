require_relative './repos/merchant_repository'
require_relative './repos/invoice_repository'
require_relative './repos/item_repository'
require_relative './repos/invoice_item_repository'
require_relative './repos/customer_repository'
require_relative './repos/transaction_repository'


class SalesEngine
  attr_accessor :merchant_repository
  attr_reader :invoice_repository, :item_repository, :invoice_item_repository,
    :customer_repository, :transaction_repository

  def initialize
  end

  def startup
    @merchant_repository = MerchantRepository.new(:engine => self)
    @invoice_repository = InvoiceRepository.new(:engine => self)
    @item_repository = ItemRepository.new(:engine => self)
    @invoice_item_repository = InvoiceItemRepository.new(:engine => self)
    @customer_repository = CustomerRepository.new(:engine => self)
    @transaction_repository = TransactionRepository.new(:engine => self)
  end

end

if __FILE__  == $0
  engine = SalesEngine.new
  puts "engine starting up..."
  engine.startup
  puts "Done."


end

