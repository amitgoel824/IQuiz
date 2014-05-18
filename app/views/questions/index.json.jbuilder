json.array!(@questions) do |question|
  json.extract! question, :id, :statement, :option1, :option2, :option3, :option4, :answer, :stars, :category_id
  json.url question_url(question, format: :json)
end
