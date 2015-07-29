require 'pry'
module List

  def all
    @things
  end
  def random
    length = @things.length
    random_index = rand(0..length-1)
    @things[random_index]
  end
  def things=(things)
    @things = things
  end
  def things
    @things ||= "asdfasd"
    @things
  end
end