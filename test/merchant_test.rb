require_relative 'test_helper.rb'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:id => '1',
                        :name => 'Matt',
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
  end
  def test_it_has_a_name_accessor
    @merchant = Merchant.new(@example_record1)
    assert @merchant.respond_to?(:name)
  end
  def test_it_has_a_created_at_accessor
    @merchant = Merchant.new(@example_record1)
    assert @merchant.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @merchant = Merchant.new(@example_record1)
    assert @merchant.respond_to?(:updated_at)
  end
  def test_it_does_NOT_have_an_accessor_it_shouldnt
    @merchant = Merchant.new(@example_record1)
    refute @merchant.respond_to?(:description)
  end
  
  
end