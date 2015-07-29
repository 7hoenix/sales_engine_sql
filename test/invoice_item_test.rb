require_relative 'test_helper.rb'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:item_id => '2310',
                         :invoice_id => '5603',
                         :quantity => "2",
                         :unit_price => "12412",
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
  end
  def test_it_has_a_item_id_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:item_id)
  end
  def test_it_has_a_invoice_id_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:invoice_id)
  end
  def test_it_has_a_quantity_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:quantity)
  end
  def test_it_has_a_unit_price_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:unit_price)
  end
  def test_it_has_a_created_at_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @invoice_item = InvoiceItem.new(@example_record1)
    assert @invoice_item.respond_to?(:updated_at)
  end
  def test_it_does_NOT_have_an_accessor_it_should_not
    @invoice_item = InvoiceItem.new(@example_record1)
    refute @invoice_item.respond_to?(:first_name)
  end
  
  
end