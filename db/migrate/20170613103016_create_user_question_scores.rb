class CreateUserQuestionScores < ActiveRecord::Migration[5.0]
  def change
    create_table :user_question_scores do |t|
      t.boolean :correct
      t.boolean :incorrect
      t.boolean :blank
      t.boolean :partial
      t.decimal :value
      t.decimal :percentage
      t.decimal :effective_score
      t.references :question, foreign_key: true
      t.references :exam_attempt, foreign_key: true
      t.references :exam_set, foreign_key: true
      t.references :score_name, foreign_key: true

      t.timestamps
    end
  end
end
