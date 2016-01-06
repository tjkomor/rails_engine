require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of customers' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of customers' do
    get :index, format: :json
    assert_equal Item.count, json_response.count
  end

  test '#index contains customers that have the correct properties' do
    get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer["last_name"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Customer.first.id
    assert_response :success
  end

  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end

end
