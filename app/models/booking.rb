class Booking < ActiveRecord::Base
  belongs_to :user, :class_name => 'User'
  belongs_to :money, foreign_key: "transaction_id", :class_name => 'Transaction'
  belongs_to :post, :class_name => 'Post'
end
