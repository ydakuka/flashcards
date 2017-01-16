class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :original
      t.text :translated
      t.date :review

      t.timestamps
    end
  end
end
