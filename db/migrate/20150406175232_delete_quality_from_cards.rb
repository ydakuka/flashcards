class DeleteQualityFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :quality
  end
end
