require_relative '../loader.rb'
require_relative '../objects/merchant.rb'
require_relative '../modules/util'

class MerchantRepository
  include Util

  attr_accessor :merchants
  attr_reader :engine, :records

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'merchants.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @merchants = populate_merchants(loaded_csvs)
    @records = @merchants
  end

  def create_record(record)
    Merchant.new(record)
  end

  def populate_merchants(loaded_csvs)
    merchants = {}
    loaded_csvs.each do |merchant|
      id = merchant.first
      record = merchant.last
      record[:repository] = self
      merchants[id] = create_record(record)
    end
    merchants
  end

  def most_revenue(x)
    all.max_by(x) {|merchant| merchant.revenue}
  end

  def most_items(x)
    all.max_by(x) {|merchant| merchant.items.length}
  end

  def revenue(date)
    sum = 0
    all.each do |merchant|
      sum += merchant.revenue(date)
      end
    sum
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end