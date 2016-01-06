class TransactionSerializer < ActiveModel::Serializer
  attributes :credit_card_number,
             :result,
             :created_at,
             :updated_at,
             :invoice_id
end
