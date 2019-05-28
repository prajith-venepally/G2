class RemoveUserFromSearch < ActiveRecord::Migration[5.2]
  def change
    remove_column :searches, :user_id, :integer
  end
end
