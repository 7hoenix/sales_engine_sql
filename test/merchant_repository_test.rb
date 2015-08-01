require_relative 'test_helper.rb'
require_relative '../lib/repos/merchant_repository'
require_relative '../lib/sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new(:filename => './fixtures/Merchants.csv')
    @se = SalesEngine.new
    @se.startup
  end 

  def test_make_sure_we_can_instantiate
    assert @merchant_repository.class == MerchantRepository
  end

  def test_we_can_make_instances_of_merchant

    hash = {:name=>"Willms and Sons", :created_at=>"2012-03-27 14:53:59 UTC", :updated_at=>"2012-03-27 14:53:59 UTC"}
    merchant = @merchant_repository.add_merchant(hash)
    
    expected = "Willms and Sons"
    result = merchant.name

    assert_equal expected,  result
  end

  def test_we_can_populate_merchants
    assert @merchant_repository.merchants.length > 20
  end

  def test_we_can_access_a_merchants_info_from_the_merchant_repo_class
    expected = "Bechtelar, Jones and Stokes"
    result = @merchant_repository.merchants[10].name

    assert_equal expected, result
  end

  def test_it_knows_merchant_with_most_revenue
    expected = @se.merchant_repository.find_by_id(44)
    actual = @se.merchant_repository.most_revenue(1)

    assert_equal 1, actual.length, "Supposed to find only one"
    assert_equal expected, actual.first
  end

  def test_it_knows_top_10_merchants_for_revenue
    top_10 = @se.merchant_repository.most_revenue(10)

    expected = [44, 84, 78, 79, 86, 38, 14, 53, 90, 26]
    actual = top_10.map {|merchant| merchant.id}

    assert_equal expected, actual
  end
end