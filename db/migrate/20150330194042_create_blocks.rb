class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
