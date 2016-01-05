class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(invoice_item_params)
  end

  def find
    respond_with InvoiceItem.where(invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.where("#{params.first.first}": params.first.last)
  end

  def create
    respond_with InvoiceItem.create(invoice_item_params)
  end

  def update
    respond_with InvoiceItem.update(params[:id], invoice_item_params)
  end

  def destroy
    respond_with InvoiceItem.destroy(params[:id])
  end

  private

  def invoice_item_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end

end
