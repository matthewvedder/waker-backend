class AddDeletedAtToLike < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :deleted_at, :datetime
    add_index :likes, :deleted_at
  end
end
