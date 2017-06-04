class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :roll_number
      t.string :role
      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.date :reset_password_sent_at
      t.integer :sign_in_count
      t.date :current_sign_in_at
      t.date :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.date :remember_created_at
      t.string :confirmation_token
      t.date :confirmed_at
      t.date :confirmation_sent_at

      t.timestamps
    end
  end
end
