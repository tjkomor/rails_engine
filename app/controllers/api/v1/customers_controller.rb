class Api::V1::CustomersController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate!

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def create
    respond_with Customer.create(customer_params)
  end

  def update
    respond_with Customer.update(params[:id], customer_params)
  end

  def destroy
    respond_with Customer.destroy(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :description, :image_url)
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
