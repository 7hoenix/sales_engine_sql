require 'pry'
require_relative '../loader.rb'
require_relative '../objects/invoice_item.rb'

class InvoiceItemRepository
  attr_accessor :invoice_items

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, './data/fixtures/invoice_items.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @invoice_items = populate_invoice_items(loaded_csvs)
  end

  def add_invoice_item(record)
    InvoiceItem.new(record)
  end

  def populate_invoice_items(loaded_csvs)
    invoice_items = {}
    loaded_csvs.each do |invoice_item|
      id = invoice_item.first
      record = invoice_item.last
      record[:repository] = self
      invoice_items[id] = add_invoice_item(record)
    end
    invoice_items
  end

end