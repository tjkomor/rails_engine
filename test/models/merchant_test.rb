require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test 'merchants are valid' do
    merchant = Merchant.first

    merchant.valid?
  end
end
