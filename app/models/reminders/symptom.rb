class Symptom < Reminder
  validates :description, presence: true
end
