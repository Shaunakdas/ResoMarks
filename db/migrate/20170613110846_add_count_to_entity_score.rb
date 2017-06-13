class AddCountToEntityScore < ActiveRecord::Migration[5.0]
  def change
  	add_column :entity_scores, :correct_count, :integer
  	add_column :entity_scores, :incorrect_count, :integer
  	add_column :entity_scores, :bonus_count, :integer
  	add_column :entity_scores, :partial_count, :integer
  	add_column :entity_scores, :blank_count, :integer
  end
end
