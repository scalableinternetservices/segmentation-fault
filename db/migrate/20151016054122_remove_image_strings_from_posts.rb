class RemoveImageStringsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :images
  end
end
