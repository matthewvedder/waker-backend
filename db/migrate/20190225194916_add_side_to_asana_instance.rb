class AddSideToAsanaInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :asana_instances, :side, :string
  end
end
