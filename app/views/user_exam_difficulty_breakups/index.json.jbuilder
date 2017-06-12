json.array!(@user_exam_difficulty_breakups) do |user_exam_difficulty_breakup|
  json.extract! user_exam_difficulty_breakup, :id, :correct, :incorrect, :attempted, :exam_attempt_id, :difficulty_level_id
  json.url user_exam_difficulty_breakup_url(user_exam_difficulty_breakup, format: :json)
end
