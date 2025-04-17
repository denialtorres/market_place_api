class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: [ :index, :show ]

  def index
    render json: OrderSerializer.new(current_user.orders).serializable_hash.to_json
  end

  def show
    order = current_user.orders.find(params[:id])
    if order
      options = { include: [ :products ] }
      render json: OrderSerializer.new(order, options).serializable_hash.to_json
    else
      head :not_found
    end
  end
end
