class Medicine < Reminder
  validates :name, presence: true
  validates :amount, presence: true
end
