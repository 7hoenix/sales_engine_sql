require_relative '../loader'
require_relative '../objects/merchant'
require_relative '../modules/table_like'

class MerchantRepository
  include TableLike

  attr_accessor :records, :all_paid_invoices, :all_unpaid_invoices
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
    items ||= engine.item_repository.all
    grouped ||= items.group_by {|item| item.merchant_id}
    ranked = grouped.max_by(x) do |merchant, items|
      items.reduce(0) do |acc, item|
        acc + item.quantity_sold
      end
    end
    ranked.flat_map{|x| self.find_by_id(x.first) }
  end

  def revenue(date)
    all.inject(0) do |acc, merchant|
      acc + merchant.revenue(date)
    end
  end

  def paid_invoices(for_merchant)
    args = {
      :repo => :invoice_repository,
      :use => :paid_invoices
    }
    @all_paid_invoices ||= engine.get(args)
    all_paid_invoices.select do |invoice|
      invoice.merchant_id == for_merchant.id
    end
  end

  def unpaid_invoices(for_merchant)
    args = {
      :repo => :invoice_repository,
      :use => :unpaid_invoices
    }
    @all_unpaid_invoices ||= engine.get(args)
    all_unpaid_invoices.select do |invoice|
      invoice.merchant_id == for_merchant.id
    end
  end
end