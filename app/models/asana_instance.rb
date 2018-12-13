class AsanaInstance < ApplicationRecord
  belongs_to :asana
  belongs_to :sequence
end
