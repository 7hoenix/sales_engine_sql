require 'pry'
require_relative '../loader.rb'
require_relative '../objects/customer.rb'
require_relative '../modules/table_like.rb'
require_relative '../modules/jit_object_builder'
require 'date'

class CustomerRepository
  include TableLike
  include JITObjectBuilder

  attr_accessor :records, :cached_invoices, :database
  attr_reader :engine, :table

  def initialize(args)
    filename = args.fetch(:filename, 'customers.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @database = args.fetch(:database, nil)

      create_customer_table
      build_for_database(loaded_csvs)
      @new_records ||= table_records

    @records = build_from(loaded_csvs)
    @table = "customers"
    @engine = args.fetch(:engine, nil)
  end

  def create_customer_table
    database.execute( "CREATE TABLE customers(id INTEGER PRIMARY KEY
                      AUTOINCREMENT, first_name VARCHAR(31), last_name
                      VARCHAR(31), created_at DATE, updated_at DATE)" );
  end

  def sanitize_record(record)
    if record[:first_name].include?("'")
      record[:first_name].gsub!("'", "")
    elsif record[:last_name].include?("'")
      record[:last_name].gsub!("'", "")
    end
    record
  end

  def add_record_to_database(record)
    record = sanitize_record(record)
    database.execute( "INSERT INTO customers(first_name, last_name, created_at,
                      updated_at) VALUES ('#{record[:first_name]}',
                      '#{record[:last_name]}',
                      #{record[:created_at].to_date},
                      #{record[:updated_at].to_date});" )
  end

  def create_record(record)
    #add_record_to_database(record) if database
    Customer.new(record)
  end

  def table_records
    database.execute( "SELECT * FROM customers" )
      .map { |row|
      Customer.new(row) }
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
    records.max_by do|customer|
      customer.revenue
    end
  end

end
