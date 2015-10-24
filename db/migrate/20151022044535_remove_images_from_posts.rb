require_relative '20151018041256_add_image_attachments_to_posts'

class RemoveImagesFromPosts < ActiveRecord::Migration
  def change
    revert AddImageAttachmentsToPosts
  end
end
