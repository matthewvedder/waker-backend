class CreatePoseInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :pose_instances do |t|
      t.text :notes
      t.integer :num_breaths

      t.timestamps
    end
  end
end
