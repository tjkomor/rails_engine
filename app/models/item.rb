class Item < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.random
    order('RANDOM()').first
  end

end
