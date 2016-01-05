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
      assert invoice_item["unit_price"]
      assert invoice_item["quantity"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

end
