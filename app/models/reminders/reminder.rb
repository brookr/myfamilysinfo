class Reminder < ActiveRecord::Base
  belongs_to :kid
  has_many :users, through: :kids
  validates :type, presence: true
end
