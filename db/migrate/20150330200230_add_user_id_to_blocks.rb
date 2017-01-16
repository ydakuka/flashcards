class AddUserIdToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :user_id, :integer, null: false
  end
end
