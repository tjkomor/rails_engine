require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test 'invoice_items are valid' do
    invoice_item = InvoiceItem.first

    invoice_item.valid?
    assert invoice_item["created_at"]
    assert invoice_item['updated_at']
    assert invoice_item["quantity"]
  end
end
