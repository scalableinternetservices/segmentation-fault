json.array!(@post_images) do |post_image|
  json.extract! post_image, :id, :image_url, :post_id
  json.url post_image_url(post_image, format: :json)
end
