class User < ActiveRecord::Base
  has_secure_password
  has_many :kids, foreign_key: :parent_id
  has_many :reminders, through: :kids
  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = SecureRandom.hex
      break token unless User.where(authentication_token: token).first
    end
  end
end
