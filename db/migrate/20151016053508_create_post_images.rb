class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.string :image_url
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
