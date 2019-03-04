class ChangeDurationAsanaInstance < ActiveRecord::Migration[5.2]
  def change
    remove_column :asana_instances, :duration
    add_column :asana_instances, :duration_qty, :decimal
    add_column :asana_instances, :duration_unit, :string
  end
end
