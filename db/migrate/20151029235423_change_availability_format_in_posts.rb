class ChangeAvailabilityFormatInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :availability, :date
  end
end
