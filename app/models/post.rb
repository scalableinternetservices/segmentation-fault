class Post < ActiveRecord::Base
  belongs_to :owner, foreign_key: "user_id", :class_name => 'User'
  validates :name, :description, :price, :categories, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :categories, exclusion: { in: %w(""), message: "A category must be selected" }
  has_many :post_images
  has_one :booking
end

# Name	Images	Description	Price	Availability