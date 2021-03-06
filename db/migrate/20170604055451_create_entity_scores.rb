class CreateEntityScores < ActiveRecord::Migration[5.0]
  def change
    create_table :entity_scores do |t|
      t.references :entity, polymorphic: true
      t.references :user, foreign_key: true
      t.references :exam_set, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
