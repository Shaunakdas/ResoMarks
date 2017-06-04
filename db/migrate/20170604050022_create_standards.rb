class CreateStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :standards do |t|
      t.string :name
      t.integer :sequence_number
      t.string :code

      t.timestamps
    end
  end
end
