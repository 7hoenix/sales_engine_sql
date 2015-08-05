require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/item'
require_relative '../modules/table_like'


class ItemRepository
  include TableLike

  attr_accessor :records, :cached_paid_invoice_items
  attr_reader :engine

  def initialize(args)
    filename = args.fetch(:filename, 'items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @records = build_from(loaded_csvs)
    @engine = args.fetch(:engine, nil)
  end

  def create_record(record)
    record[:unit_price] = BigDecimal.new(record[:unit_price]) / 100
    Item.new(record)
  end

  def paid_invoice_items(item)
    cached_paid_invoice_items ||= begin
      args = {
        :repo => :invoice_item_repository,
        :use => :paid_invoice_items
      }
      engine.get(args)
    end
    cached_paid_invoice_items.select do |ii|
      ii.item_id == item.id
    end
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

end