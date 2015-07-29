require_relative 'test_helper.rb'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  
  def setup
    @merchant_repository = MerchantRepository.new
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
end