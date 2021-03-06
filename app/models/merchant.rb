class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


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

  def self.most_items(quantity)
    sorted_merchants = all.sort_by do |merchant|
      merchant.total_items
    end
    sorted_merchants.last(quantity)
  end

  def self.revenue_by_date(date)
    joins(invoices: [:transactions, :invoice_items])
    .where('transactions.result = ?', 'success')
    .where('invoices.created_at = ?', date)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def customers_with_pending_invoices
    invoices.pending_invoice
  end

  def total_items
    invoices.successful_transactions.joins(:invoice_items).sum(:quantity)
  end

end
