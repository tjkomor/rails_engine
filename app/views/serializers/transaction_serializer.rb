class TransactionSerializer < ActiveModel::Serializer
  attributes :credit_card_number,
             :credit_card_expiration_date,
             :result,
             :created_at,
             :updated_at,
             :invoice_id
end
