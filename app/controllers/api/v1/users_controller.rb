class API::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authenticate_user_from_token!,
                     :authenticate_user!

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    else
      render json: user.errors, status: 422
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: user.errors, status: 422
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
