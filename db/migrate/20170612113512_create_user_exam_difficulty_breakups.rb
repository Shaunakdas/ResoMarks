class CreateUserExamDifficultyBreakups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_exam_difficulty_breakups do |t|
      t.integer :correct
      t.integer :incorrect
      t.integer :attempted
      t.references :exam_attempt, foreign_key: true
      t.references :difficulty_level, foreign_key: true

      t.timestamps
    end
  end
end
