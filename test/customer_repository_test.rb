require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'
require_relative '../lib/sales_engine.rb'
require 'date'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository, :db

  def setup
    @se = SalesEngine.new('./data/fixtures/')
    @se.startup
    @customer_repository = @se.customer_repository
    @db = customer_repository.database
  end

  def test_it_can_work_with_actual_customer_data
    repo = @se.customer_repository
    customer_record = {:first_name => 'george',
                        :last_name => 'timothy',
                        :created_at => Time.now.to_date,
                        :updated_at => Time.now.to_date}
    results = repo.database.query( "SELECT * FROM customers" );
    assert_equal 6, results.to_a.size
    results.close

    repo.add_record_to_database(customer_record)

    results = repo.database.query( "SELECT * FROM customers" );
    assert_equal 7, results.to_a.size
    results.close
  end

  def test_make_sure_we_can_instantiate
    assert customer_repository.class == CustomerRepository
  end

  def test_we_can_make_instances_of_Customer

    customer_record = {:first_name => 'george',
                        :last_name => 'timothy',
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
    customer = customer_repository.create_record(customer_record)

    expected = "timothy"
    result = customer.last_name

    assert_equal expected,  result
  end

  def test_we_can_access_a_customer_info_from_the_customer_repo_class
    expected = "Daugherty"
    result = customer_repository.find_by_id(7).last_name

    assert_equal expected, result
  end

  def test_all_returns_all
    expected = customer_repository.records
    result = customer_repository.all
    assert_equal(expected.length, result.length)
  end

  def test_random_returns_random
    refute (customer_repository.random == customer_repository.random) &&
      (customer_repository.random == customer_repository.random)
  end

  def test_it_knows_the_customer_who_has_paid_for_most_items
    assert_equal 1, @se.customer_repository.most_items.id
  end

  def test_it_knows_the_customer_who_has_generated_the_most_revenue
    assert_equal 4, @se.customer_repository.most_revenue.id
  end

end
