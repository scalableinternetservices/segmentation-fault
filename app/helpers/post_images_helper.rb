module PostImagesHelper
  def cache_key_for_post_image_row(post_image)
    "post_image-#{post_image.post.name}-#{post_image.image_url}"
  end
end
