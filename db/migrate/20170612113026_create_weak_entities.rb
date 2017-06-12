class CreateWeakEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :weak_entities do |t|
      t.references :exam_attempt, foreign_key: true
      t.references :entity, polymorphic: true

      t.timestamps
    end
  end
end
