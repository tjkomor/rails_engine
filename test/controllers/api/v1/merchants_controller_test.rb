require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of merchants' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of merchants' do
    get :index, format: :json
    assert_equal InvoiceItem.count, json_response.count
  end

  test '#index contains merchants that have the correct properties' do
    get :index, format: :json

    json_response.each do |merchant|
      assert merchant["created_at"]
      assert merchant['updated_at']
      assert merchant["name"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Merchant.first.id
    assert_response :success
  end

  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end

  test "#show returns correct data" do
    merchant = Merchant.create!(name: "a merchant")
    get :show, format: :json, id: merchant.id

    assert_equal merchant[:name], json_response['name']
  end

  test "#find by name returns correct record" do
    merchant = Merchant.create!(name: "a merchant")
    get :find, format: :json, name: 'a merchant'

    assert_equal merchant.name, json_response['name']
  end

  test "#find_all returns an array of records" do
    Merchant.create!(name: "merchant1")
    Merchant.create!(name: "merchant1")
    get :find_all, format: :json, name: 'merchant1'

    assert_equal 2, json_response.count
  end

  test "#items returns associated records" do
    merchant = Merchant.create!(name: "merchant")
    item = merchant.items.create!(name: 'item', unit_price: '12345')
    get :items, format: :json, id: merchant.id

    assert_equal 1, json_response.count
    assert_equal item.name, json_response.first['name']
  end


  test "#revenue returns total revenue of successful transactions" do
    merchant      = Merchant.create!(name: "some merchant")
    item          = merchant.items.create!(name: "Item Name", unit_price: 1111)
    item1         = merchant.items.create!(name: "Item Name1", unit_price: 2222)
    invoice       = merchant.invoices.create!(status: 'shipped')
    invoice_item  = invoice.invoice_items.create!(item_id: item.id, quantity: 2, unit_price: 1111)
    invoice_item1 = invoice.invoice_items.create!(item_id: item1.id, quantity: 1, unit_price: 1231)
    transaction   = invoice.transactions.create(result: 'success')

    get :revenue, format: :json, id: merchant.id

    assert_equal '3453.0', json_response['revenue']
  end

end
