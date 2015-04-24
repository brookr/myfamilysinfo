module API
  module V1
    class KidSerializer < ActiveModel::Serializer
      attributes :id, :name, :dob, :insurance_id, :nurse_phone, :notes

      def attributes
        data = super
        data[:dob] = data[:dob].strftime("%d-%m-%Y") if data[:dob]
        data
      end
    end
  end
end
