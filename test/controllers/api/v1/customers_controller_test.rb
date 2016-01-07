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

  test '#show returns single customer data' do
    get :show, format: :json, id: Customer.first.id

    assert_response :success
  end

  test "#show returns the correct record" do
    customer = Customer.create!(first_name: "tyler", last_name: 'komoroske')
    get :show, format: :json, id: customer.id

    assert_equal customer.first_name, json_response['first_name']
  end

  test "#find by name returns correct record" do
    customer = Customer.create!(first_name: "Robbie", last_name: 'Lane')
    get :find, format: :json, first_name: 'Robbie'

    assert_equal customer.first_name, json_response['first_name']
  end

  test '#show returns correct customer' do
    get :show, format: :json, id: Customer.first.id

    assert_equal Customer.first.id, json_response["id"]
  end

  test "#transactions returns associated records" do
    customer = Customer.create!(first_name: "tyler", last_name: 'komoroske')
    invoice = customer.invoices.create!(status: 'shipped')
    transaction = invoice.transactions.create!(credit_card_number: '123456789123')
    get :invoices, format: :json, id: customer.id

    assert_equal 1, json_response.count
    assert_equal invoice.status, json_response.first['status']
  end

  test "#invoices returns associated records" do
    customer = Customer.create!(first_name: "tyler", last_name: 'komoroske')
    invoice1 = customer.invoices.create!(status: 'shipped')
    invoice2 = customer.invoices.create!(status: 'shipped')
    get :invoices, format: :json, id: customer.id

    assert_equal 2, json_response.count
    assert_equal invoice1.status, json_response.first['status']
  end
end
