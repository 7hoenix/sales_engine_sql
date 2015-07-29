require_relative 'test_helper.rb'
require_relative '../lib/objects/customer'

class CustomerTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:first_name => 'george',
                        :last_name => 'timothy',
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
  end
  def test_it_has_a_first_name_accessor
    @customer = Customer.new(@example_record1)
    assert @customer.respond_to?(:first_name)
  end
  def test_it_has_a_last_name_accessor
    @customer = Customer.new(@example_record1)
    assert @customer.respond_to?(:last_name)
  end
  def test_it_has_a_created_at_accessor
    @customer = Customer.new(@example_record1)
    assert @customer.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @customer = Customer.new(@example_record1)
    assert @customer.respond_to?(:updated_at)
  end   
end