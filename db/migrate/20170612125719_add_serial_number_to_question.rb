class AddSerialNumberToQuestion < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :sequence_number, :integer
  end
end
