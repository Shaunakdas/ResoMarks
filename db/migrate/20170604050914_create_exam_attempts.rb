class CreateExamAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_attempts do |t|
      t.string :name
      t.references :exam, foreign_key: true
      t.references :exam_set, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
