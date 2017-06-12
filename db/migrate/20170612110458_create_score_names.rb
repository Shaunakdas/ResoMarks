class CreateScoreNames < ActiveRecord::Migration[5.0]
  def change
    create_table :score_names do |t|
      t.string :display_text
      t.decimal :min
      t.boolean :min_include
      t.decimal :max
      t.boolean :max_include

      t.timestamps
    end
  end
end
