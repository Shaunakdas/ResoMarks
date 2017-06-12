class AddValueToUserEntityScore < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_entity_scores, :value, :decimal
  	add_column :user_entity_scores, :percentage, :decimal
  	add_column :user_entity_scores, :effective_score, :decimal
  	add_reference :user_entity_scores, :exam_attempt, index: true
  	add_reference :user_entity_scores, :score_name, index: true
  	remove_reference :user_entity_scores, :exam, index: true, foreign_key: true
  	remove_reference :user_entity_scores, :user, index: true, foreign_key: true
  end
end
