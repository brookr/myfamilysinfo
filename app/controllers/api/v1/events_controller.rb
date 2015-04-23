module API
  module V1
    class EventsController < API::V1::BaseController
      before_action :authenticate_user_from_token

      def index
        @kid = Kid.find(params[:kid_id])
        events = @kid.reminders
        render json: events, each_serializer: EventSerializer, status: 200
      end

      def create
        event = Reminder.new(event_params)
        event.save!
        render json: event, serializer: EventSerializer, status: 201
      end

      def update
        event = Reminder.find(params[:id])
        event.update!(event_params)
        render json: event, serializer: EventSerializer, status: 200
      end

      def destroy
        event = Reminder.find(params[:id])
        event.destroy!
        render nothing: true, status: 204
      end

      private

      def event_params
        params.require(:event).permit(:meds, :type, :datetime, :temperature,
                                      :height, :weight, :description, :kid_id)
      end
    end
  end
end
