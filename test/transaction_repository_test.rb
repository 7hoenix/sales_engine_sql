require_relative 'test_helper.rb'
require_relative '../lib/repos/transaction_repository'
require_relative '../lib/sales_engine.rb'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new
    @se.startup
    @transaction_repository = @se.transaction_repository
  end

  def test_we_can_find_results
    skip
    @engine = SalesEngine.new('./data/')
    @engine.startup
    @transaction_repo = @engine.transaction_repository
    invoices = @transaction_repo.find_all_by_invoice_id(1)
    assert_equal [2,3,4], invoices.map { |invoice| invoice.id }
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
    transaction = @transaction_repository.create_record(transaction_record)

    expected = "someothertime"
    result = transaction.updated_at

    assert_equal expected,  result
  end
  def test_we_can_populate_transactions
    assert @transaction_repository.records.length > 20
  end

  def test_it_knows_the_number_of_successful_transactions
    expected = 32
    actual = @se.transaction_repository.count

    assert_equal expected, actual
  end
end
