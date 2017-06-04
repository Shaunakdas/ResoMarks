json.array!(@subtopics) do |subtopic|
  json.extract! subtopic, :id, :name, :sequence_number, :code, :subject_id, :standard_id, :chapter_id, :topic_id, :stream_id
  json.url subtopic_url(subtopic, format: :json)
end
