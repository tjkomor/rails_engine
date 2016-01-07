require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test 'merchants are valid' do
    merchant = Merchant.first

    merchant.valid?
    assert merchant["created_at"]
    assert merchant['updated_at']
    assert merchant["name"]
  end

end
