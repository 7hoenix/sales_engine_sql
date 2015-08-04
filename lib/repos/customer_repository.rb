require 'pry'
require_relative '../loader.rb'
require_relative '../objects/customer.rb'
require_relative '../modules/util'
require_relative '../modules/table_like.rb'

class CustomerRepository
  include Util
  include TableLike

  attr_accessor :customers
  attr_reader :engine, :records

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, 'customers.csv')
    path = args.fetch(:path, './data/fixtures/') + filename
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(path)
    @records = build_from(loaded_csvs)
  end

  # def items
  #   @customers
  # end

  def create_record(record)
    Customer.new(record)
  end
end