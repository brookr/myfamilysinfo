module API
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes :name, :kid_id, :datetime, :type, :amount, :temperature,
                 :height, :weight, :description

      def attributes
        data = super
        data.select { |key, value| value.present? }
      end
    end
  end
end
