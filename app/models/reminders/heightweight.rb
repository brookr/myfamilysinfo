class Heightweight < Reminder
  validates :height, presence: true
  validates :weight, presence: true
end
