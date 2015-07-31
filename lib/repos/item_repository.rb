require 'pry'
require_relative '../loader.rb'
require_relative '../objects/item.rb'
require_relative '../modules/util'

class ItemRepository
  include Util

  attr_accessor :items
  attr_reader :engine

  def initialize(args)
    @engine = args.fetch(:engine, nil)
    filename = args.fetch(:filename, './data/fixtures/items.csv')
    @loader = Loader.new
    loaded_csvs = @loader.load_csv(filename)
    @items = populate_items(loaded_csvs)
    @records = @items
  end

  def add_item(record)
    Item.new(record)
  end

  def populate_items(loaded_csvs)
    items = {}
    loaded_csvs.each do |item|
      id = item.first
      record = item.last
      record[:repository] = self
      items[id] = add_item(record)
    end
    items
  end

end