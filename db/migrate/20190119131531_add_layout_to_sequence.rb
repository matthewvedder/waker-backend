class AddLayoutToSequence < ActiveRecord::Migration[5.1]
  def change
    add_column :sequences, :layout, :jsonb, null: false, default: []
  end
end
