require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/item'
require_relative '../modules/util'
require_relative '../modules/table_like'


class ItemRepository
  include Util
  include TableLike

  attr_accessor :records
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @records = build_from(loaded_csvs)
  end

  def create_record(record)
    record[:unit_price] = BigDecimal.new(record[:unit_price]) / 100
    Item.new(record)
  end

  def paid_invoice_items(for_item)
    match = for_item.id
    key = for_item.class.to_s.downcase + "_id"
    args = {}
    
    args[:repo] = :invoice_item_repository
    args[:use] = :paid_invoice_items
    engine.get(args).select{|ii| ii.send(key.to_sym) == match}
  end

  def paid_invoices(for_item)
    paid_invoice_items(for_item).map {|ii| ii.invoice}.uniq
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