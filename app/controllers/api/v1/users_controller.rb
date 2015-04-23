module API
  module V1
    class UsersController < API::V1::BaseController
      before_action :authenticate_user_from_token, only: :update

      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: 201
      end

      def update
        user = User.find(params[:id])
        return render_404 if user.id != @current_user.id
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
