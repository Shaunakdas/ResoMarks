json.array!(@user_question_scores) do |user_question_score|
  json.extract! user_question_score, :id, :correct, :incorrect, :blank, :partial, :value, :percentage, :effective_score, :question_id, :exam_attempt_id, :exam_set_id, :score_name_id
  json.url user_question_score_url(user_question_score, format: :json)
end
