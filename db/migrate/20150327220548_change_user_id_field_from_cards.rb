class ChangeUserIdFieldFromCards < ActiveRecord::Migration
  def change
    change_column :cards, :user_id, :integer, null: false
  end
end
