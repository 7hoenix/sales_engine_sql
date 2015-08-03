require 'pry'
require_relative '../loader.rb'
require_relative '../objects/invoice.rb'
require_relative '../modules/util'

class InvoiceRepository
  include Util

  attr_accessor :invoices
  attr_reader :engine, :records

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
end