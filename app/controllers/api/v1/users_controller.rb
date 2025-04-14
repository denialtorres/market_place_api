class Api::V1::UsersController < ApplicationController

  # GET /users/:id
  def show
    user = User.find(params[:id])
    render json: user
  end
end
