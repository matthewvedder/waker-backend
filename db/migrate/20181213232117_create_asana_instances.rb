class CreateAsanaInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :asana_instances do |t|
      t.text :notes
      t.integer :num_breaths

      t.timestamps
    end
  end
end
