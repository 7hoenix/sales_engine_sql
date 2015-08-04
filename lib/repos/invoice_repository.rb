require 'pry'
require_relative '../loader'
require_relative '../objects/invoice'
require_relative '../modules/util'
require_relative '../modules/table_like'

class InvoiceRepository
  include Util
  include TableLike

  attr_accessor :invoices, :records
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'invoices.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @records = build_from(loaded_csvs)
  end

  def create_record(record)
    Invoice.new(record)
  end

  def clean_status(match)
    match =~ /\bshipped|unshipped\b/
  end

  def paid_invoices
    @paid_invoices ||= all.select(&:paid?)
  end

  def create(args)
    record = {
      :id => next_id,
      :customer_id => (args[:customer].id),
      :merchant_id => (args[:merchant].id),
      :status => args[:status],
      :created_at => timestamp,
      :updated_at => timestamp,
      :repository => self
    }
    items = args[:items]
    records[record[:id]] = create_record(record)
    invoice = find_by_id(record[:id])
    invoice.add_items(items)
    invoice
  end

  def charge(args, invoice)
    engine.charge(args, invoice.id)
  end

  def add_items(items, invoice)
    engine.add_items(items, invoice.id)
  end



end