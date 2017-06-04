json.array!(@user_phone_numbers) do |user_phone_number|
  json.extract! user_phone_number, :id, :number, :user_id
  json.url user_phone_number_url(user_phone_number, format: :json)
end
