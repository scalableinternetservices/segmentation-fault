class Post < ActiveRecord::Base
  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :categories, exclusion: { in: %w(""), message: "A category must be selected" }
  has_many :post_images
end

# Name	Images	Description	Price	Availability