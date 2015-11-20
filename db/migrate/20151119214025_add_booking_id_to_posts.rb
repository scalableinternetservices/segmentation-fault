class AddBookingIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :booking_id, :integer
  end
end
