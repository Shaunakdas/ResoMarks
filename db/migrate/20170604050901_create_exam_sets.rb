class CreateExamSets < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_sets do |t|
      t.string :name
      t.integer :sequence_number
      t.date :exam_date
      t.string :code
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
