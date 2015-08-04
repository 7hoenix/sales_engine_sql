require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/invoice_item.rb'
require_relative '../modules/util'

class InvoiceItemRepository
  include Util

  attr_accessor :invoice_items
  attr_reader :engine, :records

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'invoice_items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @invoice_items = populate_invoice_items(loaded_csvs)
    @records = @invoice_items
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
      record[:unit_price] = BigDecimal.new(record[:unit_price])
      invoice_items[id] = add_invoice_item(record)
    end
    invoice_items
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  # def paid_invoice_items
  #   @paid_invoice_items ||= engine.invoice_repository.paid_invoices.map do |invoice|
  #     invoice.invoice_items
  #   end.flatten
  # end

  def paid_invoice_items
    args = {:repo => :invoice_repository, :use => :paid_invoices}
    @paid_invoices ||= engine.get(args)
    @paid_invoice_items ||= @paid_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  # def paid_invoice_items(for_object)
  #   match = for_object.id
  #   key = for_object.class.to_s.downcase + "_id"
  #   args = {}
    
  #   args[:use] = __callee__
  #   args[:repo] = :invoice_item_repository
  #   engine.get(args).select{|ii| ii.send(key.to_sym) == match}
  # end

end