class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :hint_text
      t.boolean :partial
      t.integer :correct_score
      t.integer :incorrect_score
      t.integer :blank_score
      t.integer :per_option_score
      t.references :difficulty_level, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :standard, foreign_key: true
      t.references :chapter, foreign_key: true
      t.references :stream, foreign_key: true
      t.references :subtopic, foreign_key: true
      t.references :exam, foreign_key: true
      t.references :exam_set, foreign_key: true

      t.timestamps
    end
  end
end
