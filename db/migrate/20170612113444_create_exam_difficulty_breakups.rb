class CreateExamDifficultyBreakups < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_difficulty_breakups do |t|
      t.integer :count
      t.references :exam, foreign_key: true
      t.references :difficulty_level, foreign_key: true

      t.timestamps
    end
  end
end
