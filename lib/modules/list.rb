require 'pry'
module List

  def all
    @records
  end
  def random
    length = @records.length
    random_index = rand(0..length-1)
    @records[random_index]
  end
end