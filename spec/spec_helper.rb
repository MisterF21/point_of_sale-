require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'product'
require 'cashier'
require 'purchase'
require 'customer'

database_configuration = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Product.all { |product| product.destroy }
    Cashier.all { |cashiers| cashiers.destroy}
    Purchase.all { |purchase| purchase.destroy}
  end
end
