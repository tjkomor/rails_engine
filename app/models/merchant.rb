class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.random
    order('RANDOM()').first
  end

  def successful_invoices
    self.invoices.successful_transactions
  end

  def top_customer_id
    customers = Hash.new(0)
    successful_invoices.each do |invoice|
      customers[invoice[:customer_id]] += 1
    end
    customers.select {|k,v| v == customers.values.max }
  end

  def favorite_customer
    Customer.find(top_customer_id.keys.first)
  end

  def revenue
    revenue_total = self.invoices.successful_transactions.joins(:invoice_items).sum('quantity * unit_price')
    {'revenue' => revenue_total}
  end

  def customers_with_pending_invoices
    customers.joins(invoices: :transactions)
  end
end
