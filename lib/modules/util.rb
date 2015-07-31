require_relative './list'
require_relative './find'
require_relative './find_by_x.rb'

module Util
  include List
  include Find
  include FindByX

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