class AddVerifiedToSequences < ActiveRecord::Migration[6.0]
  def change
    add_column :sequences, :verified, :bool, default: false
  end
end
