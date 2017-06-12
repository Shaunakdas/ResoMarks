json.array!(@score_names) do |score_name|
  json.extract! score_name, :id, :display_text, :min, :min_include, :max, :max_include
  json.url score_name_url(score_name, format: :json)
end
