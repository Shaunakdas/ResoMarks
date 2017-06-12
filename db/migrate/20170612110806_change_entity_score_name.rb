class ChangeEntityScoreName < ActiveRecord::Migration[5.0]
  def change
  	rename_table :entity_scores, :user_entity_scores
  end
end
