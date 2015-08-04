require_relative './repos/merchant_repository'
require_relative './repos/invoice_repository'
require_relative './repos/item_repository'
require_relative './repos/invoice_item_repository'
require_relative './repos/customer_repository'
require_relative './repos/transaction_repository'


class SalesEngine
  attr_accessor :merchant_repository
  attr_reader :invoice_repository, :item_repository, :invoice_item_repository,
    :customer_repository, :transaction_repository, :path

  def initialize(path = './data/fixtures/')
    @path = path
  end

  def startup
    @merchant_repository = MerchantRepository.new(:path => path, :engine => self)
    @invoice_repository = InvoiceRepository.new(:path => path, :engine => self)
    @item_repository = ItemRepository.new(:path => path, :engine => self)
    @invoice_item_repository = InvoiceItemRepository.new(:path => path, :engine => self)
    @customer_repository = CustomerRepository.new(:path => path, :engine => self)
    @transaction_repository = TransactionRepository.new(:path => path, :engine => self)
  end

    # engine.get(__callee__, :invoice_items_repository, with_value, with_foreign)
  def get(args)
    # puts args.inspect
    repo = args.delete(:repo)
    use = args.delete(:use)
    self.send(repo).send(use)
  end

  # invoice.charge(credit_card_number: "4444333322221111",
  #              credit_card_expiration: "10/13", result: "success"
  def charge(args, invoice)
    self.transaction_repository(args, invoice)
  end

  def add_items(args, invoice)
    self.invoice_item_repository.add_items(args, invoice)
  end

end

if __FILE__  == $0
  engine = SalesEngine.new
  puts "engine starting up..."
  engine.startup
  puts "Done."
end

