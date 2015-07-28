require_relative 'test_helper.rb'
require_relative '../lib/loader'

class LoaderTest < Minitest::Test
  def setup
    @loader = Loader.new
  end

  def test_something
    assert true
  end
  def test_it_doesnt_need_any_args_to_instantiate

    assert @loader
  end
  def test_it_can_read_a_file
    lines = @loader.get_lines("./README.md")
    
    assert lines
  end

  def test_it_can_parse_columns_from_a_header_line
    header =  "id,name,created_at,updated_at\n"
    columns = @loader.get_columns(header)
    
    expected = [:id,:name,:created_at,:updated_at]
    result = columns
    
    assert_equal expected,result
  end
end