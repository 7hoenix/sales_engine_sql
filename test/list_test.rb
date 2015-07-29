require_relative 'test_helper.rb'
require_relative '../lib/list'

class TestClass1
  include List
  def initialize
    self.things="bye"
  end
  
end


class ListTest < Minitest::Test
  
  
  
  def test_we_can_set_our_list_of_things
    test1 = TestClass1.new
    
    test1.things="hi"
    expected = "hi"
    result = test1.things
    
    assert_equal(expected, result)
  end
  
  def test_we_can_set_our_list_of_things_as_a_hash
    test1 = TestClass1.new
    
    test1.things = { 1 => {:name => 'bringle pop',
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
      assert_equal(75108, test1.things[2][:unit_price])
  end
  def test_we_can_return_our_list_of_things_as_a_hash
        test1 = TestClass1.new
      things = { 1 => {:name => 'bringle pop',
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
      test1.things = things
      expected = things
      result = test1.all     
      assert_equal(expected, result)
  end
  def test_random_returns_a_random_thing
    test1 = TestClass1.new
    
    things = { 1 => {:name => 'bringle pop',
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
        
    test1.things = things
    expected = things[1]
    test1.stub :rand, 1 do
      result = test1.random
      assert_equal(expected, result)
    end
  end
end
