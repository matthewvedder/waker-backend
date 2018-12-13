class AddFieldsToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :asana_instances, :asana_id, :integer
    add_column :asana_instances, :sequence_id, :integer
  end
end
