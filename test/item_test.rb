require_relative 'test_helper.rb'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:name => 'bringle pop',
                        :description => 'fizzy, lizzy, bringle pop',
                        :unit_price => 75107,
                        :merchant_id => 250,
                        :created_at => "sometime",
                        :updated_at => "someothertime",}
  end
  def test_it_has_a_name_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:name)
  end
  def test_it_has_a_description_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:description)
  end
  def test_it_has_a_unit_price_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:unit_price)
  end
  def test_it_has_a_merchant_id_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:merchant_id)
  end
  def test_it_has_a_created_at_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @item = Item.new(@example_record1)
    assert @item.respond_to?(:updated_at)
  end
  def test_it_does_NOT_have_an_accessor_it_should_not
    @item = Item.new(@example_record1)
    refute @item.respond_to?(:first_name)
  end
  
  
end