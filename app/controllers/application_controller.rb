class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  # protect_from_forgery with: :exception
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  def after_sign_in_path_for(resource)
    user_path
  end

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user = user_token && User.find_by_authentication_token(user_token.to_s)
    if user
      sign_in user, store: false
    end
  end

  def json_request?
    request.format.json?
  end

  # private
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user
end
