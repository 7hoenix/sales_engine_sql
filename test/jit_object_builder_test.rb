require_relative 'test_helper'
require_relative '../lib/modules/jit_object_builder'

class JITObjectBuilderTest < Minitest::Test
  def test_it_can_build_a_single_instance
    skip
    customer_info = {type: 'customer', id: 1, first_name: 'justin'}
    customer = JITObjectBuilder.build_object(customer_info)
    assert_kind_of Customer, customer
  end

end
