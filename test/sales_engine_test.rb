require_relative 'test_helper.rb'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  
  def setup
    @engine = SalesEngine.new
  end
  
  def test_something
    assert true
  end
  
end