require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test 'invoice_items are valid' do
    invoice_item = InvoiceItem.first

    invoice_item.valid?
  end
end
