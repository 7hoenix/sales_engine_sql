module RecordLike
  def ==(other)
    if other.is_a?(self.class)
      # columns do |column|
      #   self.send(column) == other.send(column)
      # end.all?
      self.id == other.id
    end
  end

  def columns
    self.instance_variables.map{|var| var.to_s.delete('@').to_sym}
  end

  def to_dollars(cents)
    (cents / 100).round(2)
  end
end