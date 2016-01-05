require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test '#index responds to json' do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns an array of transactions' do
    get :index, format: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of transactions' do
    get :index, format: :json
    assert_equal Transaction.count, json_response.count
  end

  test '#index contains transactions that have the correct properties' do
    get :index, format: :json

    json_response.each do |transaction|
      assert transaction["credit_card_number"]
      assert transaction['credit_card_expiration_date']
      assert transaction["updated_at"]
      assert transaction["created_at"]
      assert transaction["result"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Transaction.first.id
    assert_response :success
  end

end