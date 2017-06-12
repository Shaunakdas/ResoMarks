json.array!(@exam_reference_scores) do |exam_reference_score|
  json.extract! exam_reference_score, :id, :average, :maximum, :highest, :lowest, :exam_id, :entity_id, :entity_type
  json.url exam_reference_score_url(exam_reference_score, format: :json)
end
