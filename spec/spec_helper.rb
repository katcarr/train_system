require('rspec')
require('line')
require('station')
require('connection')
require('pg')
require('pry')

DB = PG.connect({:dbname => "train_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM connections *;")
  end
end
