class CreateExamReferenceScores < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_reference_scores do |t|
      t.decimal :average
      t.decimal :maximum
      t.decimal :highest
      t.decimal :lowest
      t.references :exam, foreign_key: true
      t.references :entity, polymorphic: true

      t.timestamps
    end
  end
end
