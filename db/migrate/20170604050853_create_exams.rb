class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :sequence_number
      t.date :exam_date
      t.string :code

      t.timestamps
    end
  end
end
