class CreateUserGroupReferenceScores < ActiveRecord::Migration[5.0]
  def change
    create_table :user_group_reference_scores do |t|
      t.decimal :percentile
      t.integer :rank
      t.references :user_entity_score, foreign_key: true
      t.references :group, polymorphic: true
      t.references :entity, polymorphic: true

      t.timestamps
    end
  end
end
