require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'






class ListTest < Minitest::Test     
  def test_we_can_determine_if_our_records_have_x_type
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    
    result = @cust_repo.find_by(:last_name, "Sawayn")
    
    assert_equal(true, !!result[0].last.last_name)
  end
  def test_we_can_determine_if_a_record_is_on_the_list
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    expected = @cust_repo.customers[26].last_name
    result = @cust_repo.find_by(:last_name, "Sawayn")
    
    assert_equal(expected, result[0].last.last_name)
    
  end
  def test_we_return_an_empty_array_if_the_record_doesnt_exist
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    expected = []
    result = @cust_repo.find_by(:last_name, "Sasdsn")
    
    assert_equal(expected, result)
  end
end