module API
  module V1
    class BaseController < ApplicationController
      class UnauthorizedError < RuntimeError
      end

      include ActionController::HttpAuthentication::Token

      skip_before_action :verify_authenticity_token

      private

      def authenticate_user_from_token
        @current_user = User.find_by(authentication_token: get_auth_token)
        raise UnauthorizedError unless @current_user
      end

      def default_serializer_options
        { root: false }
      end

      def get_auth_token
        auth_header = request.env['HTTP_AUTHORIZATION']
        token = auth_header && auth_header.split('=').last
        token || params[:auth_token]
      end

      rescue_from UnauthorizedError, with: :render_401

      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404

      rescue_from ActiveRecord::RecordInvalid do |exception|
        render_422(exception.record)
      end

      def render_400
        render bad_request_error
      end

      def bad_request_error
        { json: { "message": "Problems parsing JSON"}, status: 400 }
      end

      def render_401
        render json: { "message": "Authentication token missing or invalid"}, status: 401
      end

      def render_404
        render object_not_found_error
      end

      def object_not_found_error
        { json: { "message": "Object does not exist" }, status: 404 }
      end

      def render_422(object)
        render invalid_object_error(object)
      end

      def invalid_object_error(object)
        error_object = { message: "Validation failed", errors: [] }
        object.errors.messages.each do |field, error|
          new_err = { resource: object.class.to_s, field: field.to_s, code: invalid_object_error_code(error.first) }
          error_object[:errors] << new_err
        end
        { json: error_object, status: 422 }
      end

      def invalid_object_error_code(message)
        if message.match(/blank/)
          'missing_field'
        elsif message.match(/taken/)
          'unique_field'
        elsif message.match(/in the future/)
          'invalid_field'
        end
      end
    end
  end
end
