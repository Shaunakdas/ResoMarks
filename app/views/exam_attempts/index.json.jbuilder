json.array!(@exam_attempts) do |exam_attempt|
  json.extract! exam_attempt, :id, :name, :exam_id, :exam_set_id, :user_id
  json.url exam_attempt_url(exam_attempt, format: :json)
end
