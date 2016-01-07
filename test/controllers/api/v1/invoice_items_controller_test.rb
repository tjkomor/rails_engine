require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of invoice items' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of invoice items' do
    get :index, format: :json
    assert_equal InvoiceItem.count, json_response.count
  end

  test '#index contains invoice items that have the correct properties' do
    get :index, format: :json

    json_response.each do |invoice_item|
      assert invoice_item["created_at"]
      assert invoice_item['updated_at']
      assert invoice_item["quantity"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test "#find by status returns the correct record" do
    invoice_item = InvoiceItem.create!(quantity: 7, unit_price: 91)
    get :find, format: :json, quantity: 7

    assert_equal invoice_item.quantity, json_response['quantity']
  end


  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end

  test '#show returns correct invoice_item' do
    get :show, format: :json, id: InvoiceItem.first.id

    assert_equal InvoiceItem.first.id, json_response["id"]
  end

  test "#find by status returns correct record" do
    invoice_item = InvoiceItem.create!(quantity: 3, unit_price: 12121)
    get :find, format: :json, quantity: 3

    assert_equal invoice_item.quantity, json_response['quantity']
  end

  test "#find_all returns an array of records" do
    InvoiceItem.create!(quantity: 12, unit_price: 12121)
    InvoiceItem.create!(quantity: 8, unit_price: 12121)
    get :find_all, format: :json, quantity: 12

    assert_equal 1, json_response.count
  end

  test "#invoice returns associated record" do
    invoice = Invoice.create!(status: 'shipped')
    invoice_item = invoice.invoice_items.create!(quantity: 10, unit_price: 99)
    get :invoice, format: :json, id: invoice_item.id

    assert_equal invoice.status, json_response['status']
  end

  test "#item returns associated record" do
    item = Item.create!(name: 'Item Name', unit_price: 143)
    invoice_item = item.invoice_items.create!(quantity: 1, unit_price: 21)
    get :item, format: :json, id: invoice_item.id

    assert_equal item.name, json_response['name']
  end

end
