class Api::V1::CustomersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def random
    respond_with Customer.random
  end

  def find
    if params['first_name'] || params['last_name']
      respond_with Customer.where("#{params.first.first} ILIKE ?", params.first.last).first
    else
      respond_with Customer.where("#{params.first.first}": params.first.last.to_i).first
    end
  end

  def find_all
    if params['first_name'] || params['last_name']
      respond_with Customer.where("#{params.first.first} ILIKE ?", params.first.last)
    else
      respond_with Customer.where("#{params.first.first}": params.first.last.to_i)
    end
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

end
