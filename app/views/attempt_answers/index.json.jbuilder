json.array!(@attempt_answers) do |attempt_answer|
  json.extract! attempt_answer, :id, :answer_id, :question_id, :exam_attempt_id
  json.url attempt_answer_url(attempt_answer, format: :json)
end
