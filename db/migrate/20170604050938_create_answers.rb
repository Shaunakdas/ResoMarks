class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :text
      t.string :option_text
      t.integer :sequence_number
      t.boolean :correct
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
