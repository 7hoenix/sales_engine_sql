require 'pry'
require_relative '../lib/loader.rb'
require_relative '../lib/customer.rb'

class CustomerRepository
  attr_accessor :customers
  def initialize(filename='./data/customers.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @customers = populate_customers(loaded_csvs)
  end

  def add_customer(record)
    Customer.new(record)
  end

  def populate_customers(loaded_csvs)
    customers = {}
    loaded_csvs.each do |customer|
      id = customer.first
      record = customer.last
      customers[id] = add_customer(record)
    end
    customers
  end

end