require_relative '../loader'
require_relative '../objects/merchant'
require_relative '../modules/util'
require_relative '../modules/table_like'

class MerchantRepository
  include Util
  include TableLike

  attr_accessor :records
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'merchants.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @records = build_from(loaded_csvs)
  end

  def create_record(record)
    Merchant.new(record)
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