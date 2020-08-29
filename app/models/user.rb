class User < ApplicationRecord
  extend Devise::Models
  include DeviseTokenAuth::Concerns::ActiveRecordSupport
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates :username, :presence => true
  validates :username, :uniqueness => true
  has_many :sequences
  has_many :likes
  has_many :liked_sequences, :through => :likes, :source => :sequence
  has_many :comments

  before_create :format_email

  def format_email
    self.email = self.email.downcase
  end

  def send_confirmation_notification?
    false
  end
end
