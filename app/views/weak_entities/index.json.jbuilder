json.array!(@weak_entities) do |weak_entity|
  json.extract! weak_entity, :id, :exam_attempt_id, :entity_id, :entity_type
  json.url weak_entity_url(weak_entity, format: :json)
end
