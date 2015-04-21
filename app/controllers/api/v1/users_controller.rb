class API::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authenticate_user_from_token!,
                     :authenticate_user!

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
