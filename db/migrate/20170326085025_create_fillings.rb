class CreateFillings < ActiveRecord::Migration[5.0]
  def change
    create_table :fillings do |t|
      t.string  :url
      t.string  :original_selector
      t.string  :translated_selector
      t.references :block, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
