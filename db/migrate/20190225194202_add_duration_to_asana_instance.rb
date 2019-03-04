class AddDurationToAsanaInstance < ActiveRecord::Migration[5.2]
  def change
    remove_column :asana_instances, :num_breaths
    add_column :asana_instances, :duration, :string
  end
end
