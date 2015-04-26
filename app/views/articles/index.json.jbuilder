json.array!(@articles) do |article|
  json.extract! article, :id, :title, :text, :tags
  json.url article_url(article, format: :json)
end
