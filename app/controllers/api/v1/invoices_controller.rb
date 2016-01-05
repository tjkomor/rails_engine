class Api::V1::InvoicesController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate!

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def create
    respond_with Invoice.create(invoice_params)
  end

  def update
    respond_with Invoice.update(params[:id], invoice_params)
  end

  def destroy
    respond_with Invoice.destroy(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :description, :image_url)
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
