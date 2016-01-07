require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test 'transactions are valid' do
    transaction = Transaction.first

    transaction.valid?
  end
end
