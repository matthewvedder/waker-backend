class AddDescriptionToAsana < ActiveRecord::Migration[5.1]
  def change
    add_column :asanas, :description, :text, null: false, default: ''
  end
end
