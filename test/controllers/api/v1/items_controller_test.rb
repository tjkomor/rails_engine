require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of records' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json
    assert_equal Item.count, json_response.count
  end

  test '#index contains items that have the correct properties' do
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Item.first.id
    assert_response :success
  end

  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end

  test "#find_all returns an array of records" do
    Item.create!(name: "Item Name", unit_price: 12345)
    Item.create!(name: "Item Name", unit_price: 12345)
    get :find_all, format: :json, name: 'Item Name'

    assert_equal 2, json_response.count
  end

  test "#invoice_items returns associated records" do
    item = Item.create!(name: "Item Name", unit_price: 1234)
    invoice_item1 = item.invoice_items.create!(quantity: 3, unit_price: 1234)
    invoice_item2 = item.invoice_items.create!(quantity: 2, unit_price: 1234)
    get :invoice_items, format: :json, id: item.id

    assert_equal 2, json_response.count
    assert_equal invoice_item1.quantity, json_response.first['quantity']
  end

  test "#merchant returns associated record" do
    merchant = Merchant.create!(name: 'Merchant Name')
    item = merchant.items.create!(name: "Item Name", unit_price: 12345)
    get :merchant, format: :json, id: item.id

    assert_equal merchant.name, json_response['name']
  end
end
