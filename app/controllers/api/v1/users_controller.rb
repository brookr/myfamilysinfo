class API::V1::UsersController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  # protect_from_forgery with: :null_session
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: user
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
