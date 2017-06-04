json.array!(@entity_scores) do |entity_score|
  json.extract! entity_score, :id, :entity_id, :entity_type, :user_id, :exam_set_id, :exam_id
  json.url entity_score_url(entity_score, format: :json)
end
