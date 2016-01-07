require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of invoices' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of invoices' do
    get :index, format: :json
    assert_equal Invoice.count, json_response.count
  end

  test '#index contains invoices that have the correct properties' do
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["created_at"]
      assert invoice['updated_at']
      assert invoice['status']
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test "#show returns the correct record" do
    invoice = Invoice.create!(status: "shipped")
    get :show, format: :json, id: invoice.id

    assert_equal invoice.status, json_response['status']
  end

  test "#find by status returns correct record" do
    invoice = Invoice.create!(status: "shipped")
    get :find, format: :json, status: 'shipped'

    assert_equal invoice.status, json_response['status']
  end

  test "#find_all array of records" do
    Invoice.create!(status: "shipped")
    Invoice.create!(status: "shipped")
    get :find_all, format: :json, status: 'shipped'

    assert_equal 2, json_response.count
  end

  test "#items returns associated records" do
    invoice = Invoice.create!(status: "shipped")
    item = Item.create!(name: "item", unit_price: 12345)
    invoice_item = invoice.invoice_items.create!(quantity: 99, item_id: item.id, unit_price: 12345)
    get :items, format: :json, id: invoice.id

    assert_equal 1, json_response.count
    assert_equal item.name, json_response.first['name']
  end

  test '#show returns correct invoice' do
    get :show, format: :json, id: Invoice.first.id

    assert_equal Invoice.first.id, json_response["id"]
  end

  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end
end
