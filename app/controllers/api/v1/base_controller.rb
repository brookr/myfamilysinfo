module API
  module V1
    class BaseController < ApplicationController
      before_filter :authenticate_user!
      prepend_before_filter :get_auth_token

      private

      def default_serializer_options
        { root: false }
      end

      def get_auth_token
        if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
          params[:auth_token] = auth_token
        end
      end

      def invalid_object_error(object)
        error_object = { message: "Validation failed", errors: [] }
        object.errors.messages.each do |field, error|
          new_err = {resource: object.class.to_s, field: field.to_s }
          if error.first.match(/blank/)
            new_err[:code] = 'missing_field'
          elsif error.first.match(/taken/)
            new_err[:code] = 'unique_field'
          elsif error.first.match(/in the future/)
            new_err[:code] = 'invalid_field'
          end
          error_object[:errors] << new_err
        end
        { json: error_object, status: 422 }
      end

      def object_not_found_error
        { json: { "message":"Object does not exist" }, status: 404 }
      end
    end
  end
end
