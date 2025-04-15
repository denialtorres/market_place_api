class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :update ]
  before_action :check_login, only: [ :create ]
  before_action :check_owner, only: [ :update ]

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def index
    @products = Product.all
    render json: @products
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def check_owner
    head :forbidden unless @product.user_id == current_user&.id
  end

  def product_params
    params.require(:product).permit(:title, :price, :published)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
