class CreateTargetExams < ActiveRecord::Migration[5.0]
  def change
    create_table :target_exams do |t|
      t.string :name

      t.timestamps
    end
  end
end
