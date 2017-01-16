class AddBlockIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :block_id, :integer, null: false
  end
end
