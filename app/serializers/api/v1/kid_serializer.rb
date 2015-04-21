module API
  module V1
    class KidSerializer < ActiveModel::Serializer
      attributes :id, :name, :dob, :nurse_phone

      def attributes
        data = super
        data[:dob] = data[:dob].strftime("%d-%m-%Y") if data[:dob]
        data
      end
    end
  end
end
