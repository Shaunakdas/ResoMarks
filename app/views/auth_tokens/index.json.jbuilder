json.array!(@auth_tokens) do |auth_token|
  json.extract! auth_token, :id, :number, :auth_token, :otp, :device_id, :user_id
  json.url auth_token_url(auth_token, format: :json)
end
