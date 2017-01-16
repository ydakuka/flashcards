class AddQualityToCards < ActiveRecord::Migration
  def change
    add_column :cards, :quality, :integer, null: false, default: 5
  end
end
