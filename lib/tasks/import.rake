require 'csv'
namespace :download do

  desc "Imports customer csv file into database"
  task :import, [:filename] => :environment do
    puts "Start!"
    CSV.foreach('./lib/assets/customers.csv', :headers => true) do |row|
      Customer.create(row.to_hash)
    end
  end

  desc "Imports merchants csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/merchants.csv', :headers => true) do |row|
      Merchant.create(row.to_hash)
    end
  end

  desc "Imports invoices csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/invoices.csv', :headers => true) do |row|
      Invoice.create(row.to_hash)
    end
  end

  desc "Imports items csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/items.csv', :headers => true) do |row|
      Item.create!(
        name: row.to_hash['name'],
        description: row.to_hash['description'],
        unit_price: row.to_hash['unit_price'].to_f / 100,
        merchant_id: row.to_hash['merchant_id'],
        created_at: row.to_hash['created_at'],
        updated_at: row.to_hash['updated_at']
        )
    end
  end


  desc "Imports invoice_items csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(
        unit_price: row.to_hash['unit_price'].to_f / 100,
        quantity: row.to_hash['quantity'],
        invoice_id: row.to_hash['invoice_id'],
        item_id: row.to_hash['item_id'],
        updated_at: row.to_hash['updated_at'],
        created_at: row.to_hash['created_at']
        )
    end
  end

  desc "Imports transactions csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/transactions.csv', :headers => true) do |row|
      Transaction.create!(
        invoice_id: row.to_hash['invoice_id'],
        credit_card_number: row.to_hash['credit_card_number'],
        result: row.to_hash['result'],
        created_at: row.to_hash['created_at'],
        updated_at: row.to_hash['updated_at']
        )
    end
    puts "DONE!"
  end


end
