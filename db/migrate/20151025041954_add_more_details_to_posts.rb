class AddMoreDetailsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :restrictions, :text
  end
end
