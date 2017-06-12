class CreateSpis < ActiveRecord::Migration[5.0]
  def change
    create_table :spis do |t|
      t.decimal :value
      t.references :exam_attempt, foreign_key: true
      t.references :target_exam, foreign_key: true

      t.timestamps
    end
  end
end
