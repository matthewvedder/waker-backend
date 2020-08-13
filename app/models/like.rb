class Like < ApplicationRecord
  belongs_to :user
  belongs_to :sequence
  acts_as_paranoid
end
