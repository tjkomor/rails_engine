class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate!

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
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
    params.require(:invoice_item).permit(:name, :description, :image_url)
  end

  def authenticate!
    authenticate_or_request_with_http_basic('Please authenticate to use my API') do |email, password|
      user = User.find_by(email: email)

      if user && user.authenticate(password)
        true
      else
        head :unauthorized
      end
    end
  end

end
