class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
      t.string :name
      t.integer :sequence_number
      t.string :code
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
