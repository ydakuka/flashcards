class AddReviewStepToCards < ActiveRecord::Migration
  def change
    add_column :cards, :review_step, :integer
  end
end
