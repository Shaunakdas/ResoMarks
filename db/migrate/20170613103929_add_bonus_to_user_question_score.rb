class AddBonusToUserQuestionScore < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_question_scores, :bonus, :boolean
  end
end
