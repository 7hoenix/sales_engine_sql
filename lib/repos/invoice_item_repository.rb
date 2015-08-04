require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/invoice_item.rb'
require_relative '../modules/util'
require_relative '../modules/table_like'

class InvoiceItemRepository
  include Util
  include TableLike

  attr_accessor :records
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'invoice_items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @records = build_from(loaded_csvs)
  end

  def create_record(record)
    record[:unit_price] = BigDecimal.new(record[:unit_price]) / 100
    InvoiceItem.new(record)
  end

  def paid_invoice_items
    args = {:repo => :invoice_repository, :use => :paid_invoices}
    @paid_invoices ||= engine.get(args)
    @paid_invoice_items ||= @paid_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def add_items(items, invoice_id)
    items.each do |item|
      record = {
        :id => next_id,
        :invoice_id => invoice_id,
        :item_id => item.id,
        :unit_price => item.unit_price,
        :repository => item.repository,
        :created_at => timestamp,
        :updated_at => timestamp
      }
      records[record[:id]] = create_record(record)
      end
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