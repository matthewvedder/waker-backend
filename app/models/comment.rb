class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :sequence
  acts_as_paranoid
end
