class CreateDifficultyLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :difficulty_levels do |t|
      t.string :name
      t.integer :number
      t.integer :value
      t.string :code

      t.timestamps
    end
  end
end
