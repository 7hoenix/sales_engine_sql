require 'bigdecimal'
require_relative '../loader.rb'
require_relative '../objects/item'
require_relative '../modules/table_like'

class ItemRepository
  include TableLike

  attr_accessor :records, :cached_paid_invoice_items, :database
  attr_reader :engine, :table

  def initialize(args)
    filename = args.fetch(:filename, 'items.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @database = args.fetch(:database, nil)

      create_item_table
      build_for_database(loaded_csvs)
      @new_records ||= table_records

    @records = build_from(loaded_csvs)
    @table = "items"
    @engine = args.fetch(:engine, nil)
  end

  def create_item_table
    database.execute( "CREATE TABLE items(id INTEGER PRIMARY KEY
                      AUTOINCREMENT, name VARCHAR(31), description
                      VARCHAR(255), unit_price INTEGER, merchant_id INTEGER,
                      created_at DATE, updated_at DATE)" );
  end

  def add_record_to_database(record)
    database.execute( "INSERT INTO items(name, description, unit_price,
                      merchant_id, created_at, updated_at)
                      VALUES ('#{record[:name]}',
                      '#{record[:description]}',
                      '#{record[:unit_price]}',
                      '#{record[:merchant_id]}',
                      #{record[:created_at].to_date},
                      #{record[:updated_at].to_date});" )
  end

  def create_record(record)
    record[:unit_price] = BigDecimal.new(record[:unit_price]) / 100
    Item.new(record)
  end

  def table_records
    database.execute( "SELECT * FROM items" ).map { |row| Item.new(row) }
  end

  def paid_invoice_items(item)
    cached_paid_invoice_items ||= begin
      args = {
        :repo => :invoice_item_repository,
        :use => :paid_invoice_items
      }
      engine.get(args)
    end
    cached_paid_invoice_items.select do |ii|
      ii.item_id == item.id
    end
  end

  def paid_invoices(for_item)
    paid_invoice_items(for_item).map {|ii| ii.invoice}.uniq
  end

  def most_revenue(x)
    all.max_by(x) {|item| item.revenue}
  end

  def most_items(x)
    all.max_by(x) {|item| item.quantity_sold}
  end

end
