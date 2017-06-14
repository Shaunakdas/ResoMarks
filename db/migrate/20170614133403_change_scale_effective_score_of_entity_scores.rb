class ChangeScaleEffectiveScoreOfEntityScores < ActiveRecord::Migration[5.0]
  def change
  	change_column :entity_scores, :value, :decimal, :precision => 10, :scale => 4
  	change_column :entity_scores, :percentage, :decimal, :precision => 10, :scale => 4
  	change_column :entity_scores, :effective_score, :decimal, :precision => 10, :scale => 4
  	change_column :exam_reference_scores, :average, :decimal, :precision => 10, :scale => 4
  	change_column :exam_reference_scores, :maximum, :decimal, :precision => 10, :scale => 4
  	change_column :exam_reference_scores, :highest, :decimal, :precision => 10, :scale => 4
  	change_column :exam_reference_scores, :lowest, :decimal, :precision => 10, :scale => 4
  	change_column :spis, :value, :decimal, :precision => 10, :scale => 4
  	change_column :user_group_reference_scores, :percentile, :decimal, :precision => 10, :scale => 4
  	change_column :user_question_scores, :value, :decimal, :precision => 10, :scale => 4
  	change_column :user_question_scores, :percentage, :decimal, :precision => 10, :scale => 4
  	change_column :user_question_scores, :effective_score, :decimal, :precision => 10, :scale => 4

  end
end
