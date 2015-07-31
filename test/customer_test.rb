require_relative 'test_helper.rb'
require_relative '../lib/objects/customer'
require_relative '../lib/sales_engine.rb'

class CustomerTest < Minitest::Test


  def setup
    @example_record1 =  {:first_name => 'george',
                        :last_name => 'timothy',
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
    @se = SalesEngine.new
    @se.startup
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

  def test_it_finds_invoices_for_itself
    cust = @se.customer_repository.find_by_id(1)
    invoices = cust.invoices
    invoice_ids = invoices.map{|x| x.id}.sort

    assert_equal (1..8).to_a, invoice_ids
  end

  def test_it_finds_other_invoices_for_itself
    cust = @se.customer_repository.find_by_id(2)
    invoices = cust.invoices
    invoice_ids = invoices.map{|x| x.id}.sort

    assert_equal [9], invoice_ids
  end
end