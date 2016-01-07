require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'invoices are valid' do
    invoice = Invoice.first

    invoice.valid?
    assert invoice["created_at"]
    assert invoice['updated_at']
    assert invoice['status']
  end
end
