class Purchase < ActiveRecord::Base
  belongs_to :cashier
  belongs_to :product
  belongs_to :customer
end
