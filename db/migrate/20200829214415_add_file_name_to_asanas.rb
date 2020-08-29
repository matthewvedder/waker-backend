class AddFileNameToAsanas < ActiveRecord::Migration[6.0]
  def change
    add_column :asanas, :file_name, :string
  end
end
