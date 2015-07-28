class Loader
  def initialize
  end

  def loadcsv(filename)
    lines = get_lines(filename)
    columns = get_columns(lines[0])
    
  end
  def get_lines(filename)
    File.readlines(filename)
  end
  def get_columns(str)
    columns = str.split(',').map do |column|
      column = column.chomp
      column = column.to_sym
      column
    end
  end


end