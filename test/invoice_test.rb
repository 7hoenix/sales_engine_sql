require_relative 'test_helper.rb'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:customer_id => '230',
                         :merchant_id => '5603',
                         :status => "shipped",
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
  end
  def test_it_has_a_customer_id_accessor
    @invoice = Invoice.new(@example_record1)
    assert @invoice.respond_to?(:customer_id)
  end
  def test_it_has_a_merchant_id_accessor
    @invoice = Invoice.new(@example_record1)
    assert @invoice.respond_to?(:merchant_id)
  end
  def test_it_has_a_status_accessor
    @invoice = Invoice.new(@example_record1)
    assert @invoice.respond_to?(:status)
  end
  def test_it_has_a_created_at_accessor
    @invoice = Invoice.new(@example_record1)
    assert @invoice.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @invoice = Invoice.new(@example_record1)
    assert @invoice.respond_to?(:updated_at)
  end
  def test_it_does_NOT_have_an_accessor_it_should_not
    @invoice = Invoice.new(@example_record1)
    refute @invoice.respond_to?(:first_name)
  end
  
  
end