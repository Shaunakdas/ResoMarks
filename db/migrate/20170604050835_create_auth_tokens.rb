class CreateAuthTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_tokens do |t|
      t.string :number
      t.string :auth_token
      t.integer :otp
      t.string :device_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
