class CreateAttemptAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :attempt_answers do |t|
      t.references :answer, foreign_key: true
      t.references :question, foreign_key: true
      t.references :exam_attempt, foreign_key: true

      t.timestamps
    end
  end
end
