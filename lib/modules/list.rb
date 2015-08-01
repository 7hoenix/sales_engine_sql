require_relative "find.rb"

module List
  include Find

  def all
    objects(@records)
  end
  def random
    length = @records.length
    random_index = rand(0..length-1)
    objects(@records[random_index]).reduce
  end
end