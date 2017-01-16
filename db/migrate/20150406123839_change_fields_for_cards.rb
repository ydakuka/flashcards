class ChangeFieldsForCards < ActiveRecord::Migration
  def change
    rename_column :cards, :review_attempt, :quality
    rename_column :cards, :review_step, :interval

    change_column :cards, :quality, :integer, null: false, default: 5
    change_column :cards, :interval, :integer, null: false, default: 1

    add_column :cards, :repeat, :integer, null: false, default: 1
    add_column :cards, :efactor, :float, null: false, default: 2.5
  end
end
