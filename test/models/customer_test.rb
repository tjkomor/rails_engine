require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  test 'customer is valid' do
    customer = Customer.first

    assert customer.valid?
  end

  test 'it can find top merchant id' do
    Customer.merchants = [{'1' => 2}, {'4' => 5}]
    top_merchant = {'4' => 5}
    assert_equal top_merchant, Customer.merchants.top_merchant_id
  end
end
