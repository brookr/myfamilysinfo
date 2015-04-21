module API
  module V1
    class EventsController < API::V1::BaseController
      skip_before_action :authenticate_user!

      def index
        @kid = Kid.find(params[:kid_id])
        events = @kid.reminders
        render json: events, status: 200
      end

      def create
        event = Reminder.new(event_params)
        if event.save
          render json: event, status: 201, location: api_v1_kid_events_url(event[:id])
        else
          render invalid_object_error(event)
        end
      end

      def update
        event = Reminder.find(params[:id])
        if event.update(event_params)
          render json: event, status: 200
        else
          render invalid_object_error(event)
        end
      end

      def destroy
        event = Reminder.find(params[:id])
        event.destroy!
        render nothing: true, status: 204
      rescue
        render object_not_found_error
      end

      private

      def event_params
        params.require(:event).permit(:name, :type, :datetime, :amount, :temperature,
                                      :height, :weight, :description)
      end
    end
  end
end
