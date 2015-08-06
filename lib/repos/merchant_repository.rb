require_relative '../loader'
require_relative '../objects/merchant'
require_relative '../modules/table_like'

class MerchantRepository
  include TableLike

  attr_accessor :records, :all_paid_invoices, :all_unpaid_invoices,
    :cached_dates_by_revenue, :cached_invoices, :cached_items
  attr_reader :engine

  def initialize(args)
    filename = args.fetch(:filename, 'merchants.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    loaded_csvs = Loader.new.load_csv(path)
    @records = build_from(loaded_csvs)
    @engine = args.fetch(:engine, nil)
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

  # def revenue(dates)
  #   dates = dates..dates if !(dates.is_a?(Range))
  #   invoice_items_by_date.select do |date, iis|
  #     dates.include?(date)
  #   end.values.reduce(0){|acc, ii| acc + ii.total_price}
  # end

  def dates_by_revenue(x = "all")
    if x == "all"
      all_dates_ranked
    else
      all_dates_ranked.take(x)
    end
  end

  # def all_dates_ranked
  #   invoice_items_by_date.sort_by do |date, iis|
  #     iis.reduce(0) {|acc, ii| acc + ii.total_price}
  #   end.map{|date, iis| date}
  # end

  # def invoice_items_by_date
  #   paid_invoice_items.group_by do |ii|
  #       ii.invoice.created_at
  #   end
  # end

  # def paid_invoice_items
  #   cached_invoice_items ||= begin
  #     args = { :repo => :invoice_item_repository,
  #              :use => :paid_invoice_items }
  #     engine.get(args)
  #   end
  # end

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

  def invoices
    cached_invoices ||= begin
      args = {
        :repo => :invoice_repository,
        :use => :all
      }
      engine.get(args)
    end
  end

  def items
    cached_items ||= begin
      args = {
        :repo => :item_repository,
        :use => :all
      }
      engine.get(args)
    end
  end

  def items_for(merchant)
    items.select do |item|
      item.merchant_id == merchant.id
    end
  end

  def invoices_for(merchant)
    invoices.select do |invoice|
      invoice.merchant_id == merchant.id
    end
  end
end