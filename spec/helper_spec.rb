require("rspec")
require("pg")
require("book")
require("library")
require("patron")
require ("securerandom")

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM records *;")
  end
end
