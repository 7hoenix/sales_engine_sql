require_relative 'test_helper.rb'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  
  def setup
    @transaction_repository = TransactionRepository.new('./fixtures/transactions.csv')
  end  
  def test_make_sure_we_can_instantiate
    assert @transaction_repository.class == TransactionRepository
  end
  def test_we_can_make_instances_of_Transaction
    
    transaction_record = {:invoice_id => '23034',
                        :credit_card_number => '892384923',
                        :credit_card_expiration_date => "9283",
                        :result => "good",
                        :created_at => "sometime",
                        :updated_at => "someothertime"}
    transaction = @transaction_repository.add_transaction(transaction_record)
    
    expected = "someothertime"
    result = transaction.updated_at
    
    assert_equal expected,  result
  end
  def test_we_can_populate_transactions
    assert @transaction_repository.transactions.length > 20
  end
  def test_we_can_access_a_invoices_info_from_the_invoice_repo_class
    
    expected = 4923661117104166
    result = @transaction_repository.transactions[10].credit_card_number     
    assert_equal expected, result
  end
end