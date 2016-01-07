require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test 'transactions are valid' do
    transaction = Transaction.first

    transaction.valid?
    assert transaction["credit_card_number"]
    assert transaction["updated_at"]
    assert transaction["created_at"]
    assert transaction["result"]
  end
end
