class Cashier < ActiveRecord::Base
  has_many :purchases
end

