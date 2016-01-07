require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test 'invoices are valid' do
    invoice = Invoice.first

    invoice.valid?
  end
end
