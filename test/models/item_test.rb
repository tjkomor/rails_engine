require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'items are valid' do
    item = Item.first

    item.valid?
    assert item["name"]
    assert item["description"]
    assert item['created_at']
    assert item['updated_at']
  end
end
