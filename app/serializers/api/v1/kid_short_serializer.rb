module API
  module V1
    class KidShortSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
