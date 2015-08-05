require 'pry'
require_relative '../loader.rb'
require_relative '../objects/customer.rb'
require_relative '../modules/table_like.rb'

class CustomerRepository
  include TableLike

  attr_accessor :records, :cached_invoices
  attr_reader :engine

  def initialize(args)
    filename = args.fetch(:filename, 'customers.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @records = build_from(loaded_csvs)
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

  # def most_items_for(customer)
  #   items ||= engine(:repo => :item_repository, :use => :all}
  #   grouped ||= items.group_by {|item| item.merchant_id}
  #   ranked = grouped.max_by(x) do |merchant, items|
  #     items.reduce(0) do |acc, item|
  #       acc + item.quantity_sold
  #     end
  #   end
  #   ranked.flat_map{|x| self.find_by_id(x.first) }
  # end

end