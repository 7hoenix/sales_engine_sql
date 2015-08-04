require 'pry'
require_relative '../loader.rb'
require_relative '../objects/invoice.rb'
require_relative '../modules/util'

class InvoiceRepository
  include Util

  attr_accessor :invoices, :records
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'invoices.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @invoices = populate_invoices(loaded_csvs)
    @records = @invoices
  end

  def add_invoice(record)
    Invoice.new(record)
  end

  def populate_invoices(loaded_csvs)
    invoices = {}
    loaded_csvs.each do |invoice|
      id = invoice.first
      record = invoice.last
      record[:repository] = self
      invoices[id] = add_invoice(record)
    end
    invoices
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
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
    invoices[record[:id]] = add_invoice(record)
    records = invoices
  end




end