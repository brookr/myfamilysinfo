class API::V1::SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :except => [:create]
  before_filter :ensure_params_exist, :except => [:destroy]
  respond_to :json

def create
  respond_to do |format|
    format.json {
      resource = resource_from_credentials
      #build_resource
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:password])
        render :json => {:auth_token => resource.authentication_token }, success: true, status: :created
      else
        invalid_login_attempt
      end
    }
  end
end

  protected
    def ensure_params_exist
      return unless params[:email].blank? || params[:password].blank?
      render :json=>{:message=>"missing user_login parameter"}, :status=>422
    end

    def invalid_login_attempt
      render :json=> {:message=>"Error with your login or password"}, :status=>401
    end

    def resource_from_credentials
      data = {email: params[:email]}
      if res = resource_class.find_for_database_authentication(data)
        if res.valid_password?(params[:password])
          res
        end
      end
    end
end

