json.array!(@exams) do |exam|
  json.extract! exam, :id, :name, :sequence_number, :exam_date, :code
  json.url exam_url(exam, format: :json)
end
