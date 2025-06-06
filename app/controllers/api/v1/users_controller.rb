class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]
  before_action :check_owner, only: [ :update, :destroy ]
  # GET /users/:id
  def show
    user = User.find(params[:id])
    options = { include: [ :products ] }
    render json: UserSerializer.new(user, options).serializable_hash.to_json
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).serializable_hash.to_json, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
