class Item < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    order('RANDOM()').first
  end

  def most_revenue(quantity)
    Invoice.successful_transactions
  end

  def most_items
    
  end
end
