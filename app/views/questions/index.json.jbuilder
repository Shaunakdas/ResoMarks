json.array!(@questions) do |question|
  json.extract! question, :id, :text, :hint_text, :partial, :correct_score, :incorrect_score, :blank_score, :per_option_score, :difficulty_level_id, :subject_id, :standard_id, :chapter_id, :stream_id, :subtopic_id, :exam_id, :exam_set_id
  json.url question_url(question, format: :json)
end
