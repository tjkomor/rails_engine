class Api::V1::ItemsMostRevenueController < ApplicationController
  respond_to :json

  def index
    respond_with Item.most_revenue(params['quantity'])
  end
end
