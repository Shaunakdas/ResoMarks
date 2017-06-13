class ChangeUserEntityScoreName < ActiveRecord::Migration[5.0]
  def change
  	rename_table :user_entity_scores, :entity_scores
  end
end
