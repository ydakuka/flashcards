class AddAttemptToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempt, :integer, null: false, default: 1
  end
end
