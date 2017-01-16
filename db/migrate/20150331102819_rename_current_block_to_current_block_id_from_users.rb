class RenameCurrentBlockToCurrentBlockIdFromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :current_block, :current_block_id
  end
end
