require "sqlite3"

class DatabaseWrapper
  attr_accessor :database

  def initialize
    @database = SQLite3::Database.new( ":memory:" )
    @database.results_as_hash = true
  end

end
