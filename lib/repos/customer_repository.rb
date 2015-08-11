require 'pry'
require_relative '../loader.rb'
require_relative '../objects/customer.rb'
require_relative '../modules/table_like.rb'
require_relative '../database_wrapper'

class CustomerRepository
  include TableLike

  attr_accessor :records, :cached_invoices, :database
  attr_reader :engine

  def initialize(args)
    filename = args.fetch(:filename, 'customers.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @records = build_from(loaded_csvs)
    @database = DatabaseWrapper.new.database
    @engine = args.fetch(:engine, nil)
  end

  def create_record(record)
    Customer.new(record)
  end

  def invoices(customer)
    cached_invoices ||= begin
      args = {
        :repo => :invoice_repository,
        :use => :all
      }
      engine.get(args)
    end
    cached_invoices.select do |invoice|
      invoice.customer_id == customer.id
    end
  end

  def most_items
    records.max_by{|customer| customer.paid_item_quantity}
  end

  def most_revenue
    records.max_by{|customer| customer.revenue}
  end

end
