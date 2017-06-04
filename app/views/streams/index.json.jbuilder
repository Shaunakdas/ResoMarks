json.array!(@streams) do |stream|
  json.extract! stream, :id, :name, :sequence_number, :code, :subject_id
  json.url stream_url(stream, format: :json)
end
