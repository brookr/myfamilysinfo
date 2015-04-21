class Api::V1::BaseController < ApplicationController
  def invalid_object_error(object)
    error_object = { message: "Validation failed", errors: [] }
    object.errors.messages.each do |field, error|
      new_err = {resource: object.class.to_s, field: field.to_s }
      if error.first.match(/blank/)
        new_err[:code] = 'missing_field'
      elsif error.first.match(/taken/)
        new_err[:code] = 'unique_field'
      end
      error_object[:errors] << new_err
    end
    { json: error_object, status: 422 }
  end
end
