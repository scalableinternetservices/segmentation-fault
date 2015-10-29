json.array!(@posts) do |post|
  json.extract! post, :id, :name, :images, :description, :price, :availability, :restrictions, :categories
  json.url post_url(post, format: :json)
end
