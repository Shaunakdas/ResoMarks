json.array!(@user_group_reference_scores) do |user_group_reference_score|
  json.extract! user_group_reference_score, :id, :percentile, :rank, :user_entity_score_id, :group_id, :group_type, :entity_id, :entity_type
  json.url user_group_reference_score_url(user_group_reference_score, format: :json)
end
