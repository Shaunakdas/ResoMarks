class AddEntityScoreUserRefScore < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :user_group_reference_scores, :user_entity_score, index: true
  	add_reference :user_group_reference_scores, :entity_score, index: true
  end
end
