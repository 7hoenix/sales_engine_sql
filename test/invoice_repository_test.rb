require_relative 'test_helper.rb'
require_relative '../lib/repos/invoice_repository'
require_relative '../lib/sales_engine.rb'

class InvoiceRepositoryTest < Minitest::Test
  
  def setup
    @invoice_repository = InvoiceRepository.new(:path => './fixtures/')
    @se = SalesEngine.new
    @se.startup
    @customer_1 = @se.customer_repository.find_by_id(1)
    @merchant_1 = @se.merchant_repository.find_by_id(1)
    @items = [@se.item_repository.find_by_id(1), @se.item_repository.find_by_id(1), @se.item_repository.find_by_id(2)]

  end  

  def test_make_sure_we_can_instantiate
    assert @invoice_repository.class == InvoiceRepository
  end

  def test_we_can_make_instances_of_Invoice
    
    invoice_record = {:customer_id =>"340", :merchant_id => "3052", :status => "shipped", :created_at=>"2012-03-27 14:53:59 UTC", :updated_at=>"2012-03-27 14:53:59 UTC"}
    invoice = @invoice_repository.add_invoice(invoice_record)
    
    expected = "340"
    result = invoice.customer_id
    
    assert_equal expected,  result
  end

  def test_we_can_populate_invoices
    assert @invoice_repository.invoices.length > 20
  end

  def test_we_can_access_a_invoices_info_from_the_invoice_repo_class
    
    expected = 3
    result = @invoice_repository.invoices[10].customer_id
    
    assert_equal expected, result
  end

  def test_it_creates_a_new_invoice_given_a_hash_of_arguments
    args = {
      customer: @customer_1,
      merchant: @merchant_1,
      status: "shipped",
      items: @items
    }
    @se.invoice_repository.create(args)
    invoice = @se.invoice_repository.find_by_id(88888891)
    # customer. = @se.customer_repository.find_by_id(invoice.customer_id)
    # merchant = @se.merchant_repository.find_by_id(invoice_merchant_id)

    assert_equal invoice.customer_id, @customer_1.id
    assert_equal invoice.merchant_id, @merchant_1.id
  end
end