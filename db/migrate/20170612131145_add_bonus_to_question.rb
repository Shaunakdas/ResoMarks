class AddBonusToQuestion < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :bonus, :boolean
  end
end
