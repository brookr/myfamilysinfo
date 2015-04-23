module API
  module V1
    class SessionsController < API::V1::BaseController
      before_action :user_from_credentials
      skip_before_action :authenticate_user_from_token!

      def create
        return invalid_login_attempt unless @user
        render json: @user, status: 201
      end

      protected

      def invalid_login_attempt
        render json: { "message":"Incorrect email or password" }, status: 401
      end

      def user_from_credentials
        @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      end
    end
  end
end
