class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :kid

  scope :father, -> { where(role: 'Father') }
  scope :mother, -> { where(role: 'Mother') }

  def self.sort_by_role
    map do |relationship|
      role = relationship.role
      select { |r| r.role == role }
    end
  end

end
