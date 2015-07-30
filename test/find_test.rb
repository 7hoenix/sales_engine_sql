require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'






class ListTest < Minitest::Test     
  def test_we_can_determine_if_our_records_have_x_type_find_by
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    
    result = @cust_repo.find_by(:last_name, "Sawayn")
    
    assert_equal(true, !!result.last.last_name)
  end
  def test_we_can_determine_if_our_records_have_x_type_find_by_false
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    
    result = @cust_repo.find_by(:dududududu, "Sawayn")
    
    assert_equal(false, !!result)
  end
  def test_we_can_determine_if_a_record_is_on_the_list_find_by
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    expected = @cust_repo.customers[26].last_name
    result = @cust_repo.find_by(:last_name, "Sawayn")
    
    assert_equal(expected, result.last.last_name)
    
  end
  def test_we_get_back_false_if_record_doesnt_exist_find_by
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    
    result = @cust_repo.find_by(:last_name, "Sawadfyn")
    
    assert_equal(false, result)
    
  end
  def test_we_return_an_empty_array_if_the_record_doesnt_exist_find_all
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    expected = []
    result = @cust_repo.find_all_by(:last_name, "Sasdsn")
    
    assert_equal(expected, result)
  end
  def test_we_return_an_array_of_results_if_we_find_them_find_all
    @cust_repo = CustomerRepository.new('./fixtures/customers.csv')
    
    expected = @cust_repo.customers[26].last_name
    result = @cust_repo.find_all_by(:last_name, "Sawayn")
    
    assert_equal(expected, result[0].last.last_name)
  end
end