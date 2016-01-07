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

  test 

end
