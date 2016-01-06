class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(invoice_item_params)
  end

  def find
    respond_with InvoiceItem.find_by(invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.where(invoice_item_params)
  end

  def item
    respond_with find_invoice_item.item
  end

  def invoice
    respond_with find_invoice_item.invoice
  end

  private

  def invoice_item_params
    params.permit(:item_id,
                  :quantity,
                  :unit_price,
                  :invoice_id,
                  :created_at,
                  :updated_at)
  end

  def find_invoice_item
    InvoiceItem.find_by(id: params[:id])
  end

end
