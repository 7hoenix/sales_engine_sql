require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'

class ListTest < Minitest::Test
  def setup
    @fixtures_1 = './data/fixtures/customers.csv'
  end
  def test_we_can_determine_if_our_records_have_x_type_find_by
    @cust_repo = CustomerRepository.new(:filename => './fixtures/customers.csv')

    result = @cust_repo.find_by_last_name("Sawayn")

    assert_equal(true, !!result.last_name)
  end
  def test_we_can_determine_if_a_record_is_on_the_list_find_by
    @cust_repo = CustomerRepository.new(:filename => './fixtures/customers.csv')

    expected = @cust_repo.customers[26].last_name
    result = @cust_repo.find_by_last_name("Sawayn")

    assert_equal(expected, result.last_name)

  end
  def test_we_get_back_false_if_record_doesnt_exist_find_by
    @cust_repo = CustomerRepository.new(:filename => './fixtures/customers.csv')

    result = @cust_repo.find_by_last_name("Sawadfyn")

    assert_equal(false, result)
  end

  def test_we_return_an_empty_array_if_the_record_doesnt_exist_find_all
    @cust_repo = CustomerRepository.new(:filename => './fixtures/customers.csv')

    expected = []
    result = @cust_repo.find_all_by_last_name("Sasdsn")

    assert_equal(expected, result)
  end

  def test_we_return_an_array_of_results_if_we_find_them_find_all
    @cust_repo = CustomerRepository.new(:filename => './fixtures/customers.csv')

    expected = Array
    result = @cust_repo.find_all_by_last_name("Sawayn").class

    assert_equal(expected, result)
  end

  def test_it_finds_by_id
    @cust_repo = CustomerRepository.new(:filename => @fixtures_1)
    record = {:id => "4", :first_name => "Leanne", :last_name => "Braun",
      :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC",
      :repository => @cust_repo}
    
    cust = Customer.new(record)
    found_cust = @cust_repo.find_by_id("4")

    assert_equal cust, found_cust
  end

  def test_it_finds_by_different_id
    @cust_repo = CustomerRepository.new(:filename => @fixtures_1)
    record = {:id => "2", :first_name => "Cecelia", :last_name => "Osinski",
      :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC",
      :repository => @cust_repo}

    cust = Customer.new(record)
    found_cust = @cust_repo.find_by_id("2")

    assert_equal cust, found_cust
  end

  def test_it_finds_by_first_name
    @cust_repo = CustomerRepository.new(:filename => @fixtures_1)
    record = {:id => "4", :first_name => "Leanne", :last_name => "Braun",
      :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC",
      :repository => @cust_repo}

    cust = Customer.new(record)
    found_cust = @cust_repo.find_by_first_name("Leanne")

    assert_equal cust, found_cust
  end

  def test_partial_first_name_will_not_find
    @cust_repo = CustomerRepository.new(:filename => @fixtures_1)
    record = {:id => "4", :first_name => "Leanne", :last_name => "Braun",
      :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC",
      :repository => @cust_repo}

    cust = Customer.new(record)
    found_cust = @cust_repo.find_by_first_name("Lean")

    refute_equal cust, found_cust
  end
end