module API
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :authentication_token
    end
  end
end
