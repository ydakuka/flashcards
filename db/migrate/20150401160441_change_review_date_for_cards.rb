class ChangeReviewDateForCards < ActiveRecord::Migration
  def change
    change_column :cards, :review_date, :timestamp, null: false
    change_column :cards, :review_step, :integer, null: false, default: 1
  end
end
