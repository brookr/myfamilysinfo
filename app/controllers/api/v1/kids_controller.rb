module API
  module V1
    class KidsController < API::V1::BaseController
      skip_before_action :authenticate_user!

      def index
        @kids = current_user.kids
        render json: @kids, each_serializer: API::V1::KidShortSerializer, status: 200
      end

      def show
        @kid = current_user.kids.find(params[:id])
        render json: @kid, status: 200
      end

      def create
        @kid = current_user.kids.build(kid_params)
        @kid.save!
        render json: @kid, status: 201
      end

      def update
        @kid = current_user.kids.find(params[:id])
        if allowed_to_edit!
          @kid.update!(kid_params)
          render json: @kid, status: 201
        end
      end

      def destroy
        @kid = current_user.kids.find(params[:id])
        if allowed_to_edit!
          @kid.delete
          head 204
        end
      end

      protected

      def kid_params
        params.permit(:name, :dob, :insurance_id, :nurse_phone, :notes)
      end

      def allowed_to_edit!
        return true if @kid.parent_id == current_user.id
        render_404 && false
      end
    end
  end
end
