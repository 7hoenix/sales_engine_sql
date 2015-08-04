require_relative 'test_helper.rb'
require_relative '../lib/modules/util'

class TestClass1
  include TableLike
  def initialize
  end
  
end

class ListTest < Minitest::Test
  def test_we_can_set_our_list_of_things
    test1 = TestClass1.new
    
    test1.records="hi"
    expected = "hi"
    result = test1.records
    
    assert_equal(expected, result)
  end
  
  def test_we_can_set_our_list_of_things_as_a_hash
    test1 = TestClass1.new
    
    test1.records = { 1 => {:name => 'bringle pop',
      :description => 'fizzy, lizzy, bringle pop',
      :unit_price => 75107,
      :merchant_id => 250,
      :created_at => "sometime",
      :updated_at => "someothertime",}, 
      2 => {:name => 'bringled pop',
        :description => 'fizzy, lizzy, bringled pop',
        :unit_price => 75108,
        :merchant_id => 250,
        :created_at => "sometime",
        :updated_at => "someothertime",} }
      assert_equal(75108, test1.records[2][:unit_price])
  end

end
