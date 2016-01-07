require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  test 'customer is valid' do
    customer = Customer.first

    assert customer.valid?
    assert customer["first_name"]
    assert customer["last_name"]
    assert customer['created_at']
    assert customer['updated_at']
  end

  test "top merchant id returns hash object" do
    merchant = Merchant.create!(name: "tyler")
    merchant_two = Merchant.create!(name: "marlo")

    customer = Customer.create!(first_name: "new customer",
                                last_name: "customer last")

    Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

    assert_equal Hash, customer.top_merchant_id.class
  end

end
