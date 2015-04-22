class API::V1::SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist
  respond_to :json

  def create
    user = user_from_credentials
    return invalid_login_attempt unless user
    render json: { auth_token: user.authentication_token }, success: true, status: :created
  end

  protected

  def ensure_params_exist
    return unless params[:email].blank? || params[:password].blank?
    invalid_login_attempt
  end

  def invalid_login_attempt
    render json: { "message":"Incorrect email or password" }, status: 401
  end

  def user_from_credentials
    data = { email: params[:email] }
    if user = User.find_for_database_authentication(data)
      if user.valid_password?(params[:password])
        user
      end
    end
  end
end
