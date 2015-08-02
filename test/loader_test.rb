require 'date'
require_relative 'test_helper.rb'
require_relative '../lib/loader'

class LoaderTest < Minitest::Test
  def setup
    @loader = Loader.new
  end

  
  def test_it_doesnt_need_any_args_to_instantiate

    assert @loader
  end
  
  def test_it_loads_a_hash_of_hashes     
    hash = @loader.load_csv('./fixtures/merchants.csv')
    
    expected = {:id => 3, :name=>"Willms and Sons", :created_at=>DateTime.parse("2012-03-27 14:53:59 UTC"), :updated_at=>DateTime.parse("2012-03-27 14:53:59 UTC")}
    result = hash[3]
    
    assert_equal(expected, result)
  end
end