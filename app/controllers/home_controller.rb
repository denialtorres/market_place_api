class HomeController < ApplicationController
  def index
    # Basic statistics for the dashboard
    @total_products = Product.count
    @total_users = User.count
    @total_orders = Order.count
    @recent_products = Product.includes(:user).recent.limit(5)

    render 'index'
  end
end
