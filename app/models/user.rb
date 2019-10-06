class User < ApplicationRecord
  has_secure_password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :sequences

  before_create :format_email

  def format_email
    self.email = self.email.downcase
  end
end
