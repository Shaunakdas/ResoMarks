json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :roll_number, :role, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at
  json.url user_url(user, format: :json)
end
