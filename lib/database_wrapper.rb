require "sqlite3"

class DatabaseWrapper
  attr_reader :database

  def initialize(file_name)
    @file_name = File.expand_path(file_name)
    File.delete(file_name) if File.exist?(file_name)
    @database = SQLite3::Database.new(file_name)
    @database.results_as_hash = true
  end

end
