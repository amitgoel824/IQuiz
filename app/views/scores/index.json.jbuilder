json.array!(@scores) do |score|
  json.extract! score, :id, :user_id, :category_id, :score
  json.url score_url(score, format: :json)
end
