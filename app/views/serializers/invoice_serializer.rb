class InvoiceSerializer < ActiveModel::Serializer
  attributes :status, :created_at, :updated_at
end
