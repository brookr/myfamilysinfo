module API
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes :meds, :kid_id, :datetime, :type, :temperature,
                 :height, :weight, :description, :id

      def attributes
        data = super
        data.select { |key, value| value.present? }
      end
    end
  end
end
