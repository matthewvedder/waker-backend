class AddUserToSequences < ActiveRecord::Migration[5.1]
  def change
    add_reference :sequences, :user, foreign_key: true
  end
end
