class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with find_merchant.items
  end

  def invoices
    respond_with find_merchant.invoices
  end

  private

  def find_merchant
    Merchant.find_by(id: params[:id])
  end

  def merchant_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at,
                  :date,
                  :quantity)
  end

end
