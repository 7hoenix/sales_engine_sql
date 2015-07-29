require 'pry'
require_relative '../lib/loader.rb'
require_relative '../lib/invoice.rb'

class InvoiceRepository
  attr_accessor :invoices
  def initialize(filename='./data/invoices.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @invoices = populate_invoices(loaded_csvs)
  end

  def add_invoice(record)
    Invoice.new(record)
  end

  def populate_invoices(loaded_csvs)
    invoices = {}
    loaded_csvs.each do |invoice|
      id = invoice.first
      record = invoice.last
      invoices[id] = add_invoice(record)
    end
    invoices
  end

end