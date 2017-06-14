class AddEntityScoreForeignKeyUserRefScore < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :user_group_reference_scores, :entity_scores
  end
end
