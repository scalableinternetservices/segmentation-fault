module PostsHelper
  def cache_key_for_post_row(post)
    "post-#{post.id}-#{post.name}-#{post.description}-#{post.price}-#{post.availability}-#{post.restrictions}-#{post.categories}"
  end
end
