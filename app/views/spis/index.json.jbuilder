json.array!(@spis) do |spi|
  json.extract! spi, :id, :value, :exam_attempt_id, :target_exam_id
  json.url spi_url(spi, format: :json)
end
