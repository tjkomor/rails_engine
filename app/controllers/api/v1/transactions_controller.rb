class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_by(transaction_params)
  end

  def find_all
    respond_with Transaction.where(transaction_params)
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with find_transaction.invoice
  end

  private

  def transaction_params
    params.permit(:id,
                  :invoice_id,
                  :credit_card_number,
                  :credit_card_expiration_date,
                  :result,
                  :created_at,
                  :updated_at)
  end

  def find_transaction
    Transaction.find_by(id: params[:id])
  end


end
