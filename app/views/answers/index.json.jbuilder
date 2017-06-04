json.array!(@answers) do |answer|
  json.extract! answer, :id, :text, :option_text, :sequence_number, :correct, :question_id
  json.url answer_url(answer, format: :json)
end
