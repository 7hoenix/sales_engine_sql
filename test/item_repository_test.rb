require_relative 'test_helper.rb'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  
  def setup
    @item_repository = ItemRepository.new('./fixtures/items.csv')
  end  
  def test_make_sure_we_can_instantiate
    assert @item_repository.class == ItemRepository
  end
  def test_we_can_make_instances_of_Item
    
    item_record = {:name => 'bringle pop',
                        :description => 'fizzy, lizzy, bringle pop',
                        :unit_price => 75107,
                        :merchant_id => 250,
                        :created_at => "sometime",
                        :updated_at => "someothertime",}
    item = @item_repository.add_item(item_record)
    
    expected = 75107
    result = item.unit_price
    
    assert_equal expected,  result
  end
  def test_we_can_populate_items
    assert @item_repository.items.length > 20
  end
  def test_we_can_access_a_item_info_from_the_item_repo_class
    expected = 34018
    result = @item_repository.items[10].unit_price
    assert_equal expected, result
  end
end