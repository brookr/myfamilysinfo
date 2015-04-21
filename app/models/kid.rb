class Kid < ActiveRecord::Base
  has_many :relationships
  # has_many :users, through: :relationships
  belongs_to :parent, class_name: 'User'
  has_many :reminders
  accepts_nested_attributes_for :relationships

  validates :name, presence: true
  validates_each :dob do |record, attr, _|
    next if record.dob.nil?
    record.errors.add(attr, 'cannot be in the future') if record.dob >= Date.today
  end
end
