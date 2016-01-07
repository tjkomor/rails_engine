require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'items are valid' do
    item = Item.first

    item.valid?
  end
end
