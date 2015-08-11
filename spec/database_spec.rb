require_relative "spec_helper"
require_relative "../lib/database"

RSpec.describe Database do
  describe "#database" do
    context "before we create tables" do
      it "it is empty" do
        database_wrapper = Database.new

        expect(database_wrapper.database.class).to eq Sqlite3
      end
    end
  end
end
