class Api::V1::ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def index
    @products = Product.all
    render json: @products
  end
end
