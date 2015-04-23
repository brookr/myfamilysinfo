module API
  module V1
    class UsersController < API::V1::BaseController
      skip_before_filter :verify_authenticity_token, :authenticate_user_from_token!, :authenticate_user!

      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: 201
      end

      def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user, status: 200
      end

      private
      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
