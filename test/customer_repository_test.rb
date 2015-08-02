require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  
  def setup
    @customer_repository = CustomerRepository.new(:filename => './fixtures/customers.csv')
  end  
  def test_make_sure_we_can_instantiate
    assert @customer_repository.class == CustomerRepository
  end
  def test_we_can_make_instances_of_Customer
    
    customer_record = {:first_name => 'george',
                        :last_name => 'timothy',
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
    customer = @customer_repository.add_customer(customer_record)
    
    expected = "timothy"
    result = customer.last_name
    
    assert_equal expected,  result
  end
  def test_we_can_populate_customers
    assert @customer_repository.customers.length > 20
  end
  def test_we_can_access_a_customer_info_from_the_customer_repo_class
    
    expected = "Reynolds"
    result = @customer_repository.customers[10].last_name
    
    assert_equal expected, result
  end
  def test_all_returns_all     
    expected = @customer_repository.customers
    result = @customer_repository.all
    assert_equal(expected.length, result.length)
  end
  def test_random_returns_random
    refute (@customer_repository.random == @customer_repository.random) &&
      (@customer_repository.random == @customer_repository.random)

  end
  
end