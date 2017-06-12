json.array!(@target_exams) do |target_exam|
  json.extract! target_exam, :id, :name
  json.url target_exam_url(target_exam, format: :json)
end
