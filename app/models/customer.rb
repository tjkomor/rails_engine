class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    order('RANDOM()').first
  end

  def successful_invoices
    self.invoices.successful_transactions
  end

  def top_merchant_id
    merchants = Hash.new(0)
    successful_invoices.each do |invoice|
      merchants[invoice[:merchant_id]] += 1
    end
    merchants.select {|k,v| v == merchants.values.max }
  end

  def favorite_merchant
    Merchant.find(top_merchant_id.keys.first)
  end

end
