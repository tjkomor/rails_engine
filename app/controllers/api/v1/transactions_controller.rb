class Api::V1::TransactionsController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate!

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def create
    respond_with Transaction.create(transaction_params)
  end

  def update
    respond_with Transaction.update(params[:id], transaction_params)
  end

  def destroy
    respond_with Transaction.destroy(params[:id])
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :description, :image_url)
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
