class AddPublicToSequences < ActiveRecord::Migration[6.0]
  def change
    add_column :sequences, :public, :boolean,  default: false
    add_index :sequences, :public
  end
end
