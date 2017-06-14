class ChangeScaleMinOfScoreNames < ActiveRecord::Migration[5.0]
  def change
  	change_column :score_names, :min, :decimal, :precision => 10, :scale => 2
  	change_column :score_names, :max, :decimal, :precision => 10, :scale => 2
  end
end
