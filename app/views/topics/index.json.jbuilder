json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :sequence_number, :code, :subject_id, :standard_id, :chapter_id, :stream_id
  json.url topic_url(topic, format: :json)
end
