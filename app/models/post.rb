class Post < ActiveRecord::Base
  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  has_attached_file :image
  has_many :post_images
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

# Name	Images	Description	Price	Availability