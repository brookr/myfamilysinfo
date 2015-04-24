module API
  module V1
    class KidShortSerializer < ActiveModel::Serializer
      attributes :id, :name, :nurse_phone
    end
  end
end
