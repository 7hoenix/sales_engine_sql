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
    if args.keys.include?(:x)
      x = args.delete(:x) 
      self.send(repo).send(use, x)
    else
      self.send(repo).send(use)
    end
  end

  def most_items(x)
    self.item_repository.most_items(x)
  end

  def charge(args, invoice)
    self.transaction_repository.charge(args, invoice)
  end

  def add_items(items, invoice_id)
    self.invoice_item_repository.add_items(items, invoice_id)
  end

  def inspect
    #define this
    "#{self.class}"
  end

end

if __FILE__  == $0
  engine = SalesEngine.new
  puts "engine starting up..."
  engine.startup
  puts "Done."
end

