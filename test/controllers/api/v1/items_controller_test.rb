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
      assert item['unit_price']
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

end
