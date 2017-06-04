class CreateUserPhoneNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_phone_numbers do |t|
      t.string :number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
