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

end
