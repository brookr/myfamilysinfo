class Kid < ActiveRecord::Base
  # has_many :relationships
  # has_many :users, through: :relationships
  belongs_to :parent, class_name: 'User'
  has_many :reminders
  # accepts_nested_attributes_for :relationships
end
