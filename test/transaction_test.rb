require_relative 'test_helper.rb'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  
  
  def setup
    @example_record1 =  {:invoice_id => '23034',
                        :credit_card_number => '892384923',
                        :credit_card_expiration_date => "9283",
                        :result => "good",
                        :creadted_at => "sometime",
                        :updated_at => "someothertime"}
  end
  def test_it_has_a_invoice_id_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:invoice_id)
  end
  def test_it_has_a_credit_card_number_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:credit_card_number)
  end
  def test_it_has_a_credit_card_expiration_date_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:credit_card_expiration_date)
  end
  def test_it_has_a_result_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:result)
  end
  def test_it_has_a_created_at_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:created_at)
  end
  def test_it_has_a_updated_at_accessor
    @transaction = Transaction.new(@example_record1)
    assert @transaction.respond_to?(:updated_at)
  end
  def test_it_does_NOT_have_an_accessor_it_should_not
    @transaction = Transaction.new(@example_record1)
    refute @transaction.respond_to?(:customer_id)
  end
  
  
end