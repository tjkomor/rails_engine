class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  belongs_to :customer
  belongs_to :merchant
end
