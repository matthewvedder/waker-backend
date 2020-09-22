class AsanaInstance < ApplicationRecord
  belongs_to :asana
  belongs_to :sequence
  before_destroy :remove_from_layout

  def remove_from_layout
    sequence.layout = sequence.layout.select { |instance_id| instance_id != self.id.to_s }
    sequence.save!
  end
end
