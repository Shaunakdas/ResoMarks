class ChangeUserEntityScoreNameRefScore < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :user_group_reference_scores, :entity_scores
  end
end
