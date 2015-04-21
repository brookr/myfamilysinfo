class HeightWeight < Reminder
  validates :height, presence: true, unless: Proc.new { |a| a.weight.present? }
  validates :weight, presence: true, unless: Proc.new { |a| a.height.present? }
end
