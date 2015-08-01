require_relative "find.rb"

module List
  include Find

  def all
    objects(records)
  end
  def random
    records.values.sample
  end
end