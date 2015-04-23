class Kid < ActiveRecord::Base
  belongs_to :parent, class_name: 'User'
  has_many :reminders

  validates :name, presence: true
end
