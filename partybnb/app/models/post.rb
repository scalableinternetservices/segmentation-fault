class Post < ActiveRecord::Base
  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :images, allow_blank: true, format: {
      with:  %r{\.(gif|jpg|png)\Z}i,
      message: 'Images urls must of: gif, jpg, or png'
  }
end

# Name	Images	Description	Price	Availability