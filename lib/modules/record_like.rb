module RecordLike
  def ==(other)
    if other.is_a?(self.class)
      columns do |column|
        self.send(column) == other.send(column)
      end.all?
    end
  end

  def columns
    self.instance_variables.map{|var| var.to_s.delete('@').to_sym}
  end
end