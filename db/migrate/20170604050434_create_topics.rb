class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :sequence_number
      t.string :code
      t.references :subject, foreign_key: true
      t.references :standard, foreign_key: true
      t.references :chapter, foreign_key: true
      t.references :stream, foreign_key: true

      t.timestamps
    end
  end
end
