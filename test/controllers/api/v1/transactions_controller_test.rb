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
      assert transaction["updated_at"]
      assert transaction["created_at"]
      assert transaction["result"]
    end
  end

  test '#show responds to JSON' do
    get :show, format: :json, id: Transaction.first.id
    assert_kind_of Hash, json_response
    assert_response :success
  end

  test '#random returns a valid entry' do
    get :random, format: :json
    assert_response :success
  end

  test "#find_all returns an array of records" do
    Transaction.create!(result: 'success')
    Transaction.create!(result: 'success')
    get :find_all, format: :json, result: 'success'

    assert_equal 2, json_response.count
  end

  test "#invoice returns associated record" do
    invoice = Invoice.create!(status: 'shipped')
    transaction = invoice.transactions.create!(result: 'success')

    get :invoice, format: :json, id: transaction.id

    assert_equal invoice.status, json_response['status']
  end

end
