class User < ApplicationRecord
  extend Devise::Models
  include DeviseTokenAuth::Concerns::ActiveRecordSupport
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :sequences
  has_many :likes
  has_many :liked_sequences, :through => :likes, :source => :sequence

  before_create :format_email

  def format_email
    self.email = self.email.downcase
  end
end
