require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  test 'customer is valid' do
    customer = Customer.first

    assert customer.valid?
  end

end
