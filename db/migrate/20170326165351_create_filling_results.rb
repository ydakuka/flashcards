class CreateFillingResults < ActiveRecord::Migration[5.0]
  def change
    create_table :filling_results do |t|
      t.integer :job_id
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
