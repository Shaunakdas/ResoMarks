json.array!(@exam_sets) do |exam_set|
  json.extract! exam_set, :id, :name, :sequence_number, :exam_date, :code, :exam_id
  json.url exam_set_url(exam_set, format: :json)
end
