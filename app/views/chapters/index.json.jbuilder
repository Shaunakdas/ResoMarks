json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :name, :sequence_number, :code, :subject_id, :standard_id, :stream_id
  json.url chapter_url(chapter, format: :json)
end
