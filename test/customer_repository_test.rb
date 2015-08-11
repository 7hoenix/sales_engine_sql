require_relative 'test_helper.rb'
require_relative '../lib/repos/customer_repository'
require_relative '../lib/sales_engine.rb'
require 'date'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository, :db

  def setup
    @customer_repository = CustomerRepository.new(:path => './fixtures/')
    @se = SalesEngine.new
    @se.startup
    @db = customer_repository.database
  end

  def test_we_can_create_a_new_customer_table_in_the_db
    skip
    db.execute( "CREATE TABLE customers(id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name VARCHAR(31))" );
    result = db.query( "SELECT * FROM customers" );
    assert_equal [], result.to_a
    result.close

    db.execute( "INSERT INTO customers(first_name) VALUES ('Timothy')" );

    result = db.query( "SELECT * FROM customers" );
    assert_equal 'Timothy', result.to_a.first["first_name"]
    db.execute( "DROP TABLE customers" );
  end

  def test_it_can_work_with_actual_customer_data
    repo = @se.customer_repository
    #db.execute( "CREATE TABLE customers(id INTEGER PRIMARY KEY AUTOINCREMENT,
    #  first_name VARCHAR(31), last_name VARCHAR(31), created_at DATE, updated_at
    #DATE)" );

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

    #db.execute( "INSERT INTO customers(first_name, last_name, created_at,
    #  updated_at) VALUES ('#{customer_record[:first_name]}',
    #  '#{customer_record[:last_name]}',
    #  #{customer_record[:created_at]},
    #  #{customer_record[:updated_at]});" )

    #  result = db.query( "SELECT * FROM customers" );
    #  assert_equal 1, result.to_a.size
    #db.execute( "DROP TABLE customers" );
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

  def test_we_can_populate_customers
    assert customer_repository.records.length > 20
  end

  def test_we_can_access_a_customer_info_from_the_customer_repo_class
    expected = "Reynolds"
    result = customer_repository.find_by_id(10).last_name

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
