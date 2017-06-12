json.array!(@exam_difficulty_breakups) do |exam_difficulty_breakup|
  json.extract! exam_difficulty_breakup, :id, :count, :exam_id, :difficulty_level_id
  json.url exam_difficulty_breakup_url(exam_difficulty_breakup, format: :json)
end
