require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/item.rb'
require_relative '../modules/util'


class ItemRepository
  include Util

  attr_accessor :items
  attr_reader :engine, :records

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @items = populate_items(loaded_csvs)
    @records = @items
  end

  def add_item(record)
    Item.new(record)
  end

  def create(args)
    # invoice_repository.create(customer: customer, merchant: merchant
      #status: "shipped",
    #                      items: [item1, item2, item3])

  end

  def populate_items(loaded_csvs)
    items = {}
    loaded_csvs.each do |item|
      id = item.first
      record = item.last
      record[:unit_price] = (BigDecimal.new(record[:unit_price]) / 100)
      record[:repository] = self
      items[id] = add_item(record)
    end
    items
  end

  def most_revenue(x)
    all.max_by(x) {|item| item.revenue}
  end

  def most_items(x)
    all.max_by(x) {|item| item.quantity_sold}
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end