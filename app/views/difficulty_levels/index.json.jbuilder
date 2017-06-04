json.array!(@difficulty_levels) do |difficulty_level|
  json.extract! difficulty_level, :id, :name, :number, :value, :code
  json.url difficulty_level_url(difficulty_level, format: :json)
end
