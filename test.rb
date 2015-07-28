require 'pry'
h = {1 => {:name => "john", :date => "now"}, 2 => {:name => "sallly", :date => "later"}}

h.each_with_index do |merchant, index|
  binding.pry
  id = merchant[0]
  record = merchant[1]
  @merchant[id] = Merchant.new(record)
end
