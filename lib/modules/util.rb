require_relative './list'
require_relative './find'

module Util
  include List
  include Find
  def record_type(records)
    @records
  end
  def record_type=(records)
    @records = records
  end
  def records
    @records
  end
  def records=(records)
    @records = records
  end
end