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
      Item.create(row.to_hash)
    end
  end


  desc "Imports invoice_items csv file into database"
  task :import, [:filename] => :environment do
    CSV.foreach('./lib/assets/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create(row.to_hash)
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
