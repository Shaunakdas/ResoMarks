json.array!(@standards) do |standard|
  json.extract! standard, :id, :name, :sequence_number, :code
  json.url standard_url(standard, format: :json)
end
