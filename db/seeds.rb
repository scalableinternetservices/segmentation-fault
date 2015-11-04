# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#user = CreateAdminService.new.call

require 'faker'

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

#puts 'CREATED ADMIN USER: ' << user.email

100.times do |i|
  image = File.open(Dir['app/assets/images/*.png'].sample)
  post_image = PostImage.create(image: image)

  user1 = User.create!(email: Faker::Internet.email,
                       name: Faker::Name.first_name,
                       password: '123456789',
                       password_confirmation: '123456789')

  post = Post.create(name: "Post ##{i}",
                     description: Faker::Lorem.paragraph,
                     price: rand_in_range(100, 1),
                     availability: rand_time(5.days.from_now),
                     created_at: rand_time(2.days.ago),
                     updated_at: rand_time(1.days.ago),
                     restrictions: Faker::Lorem.paragraph,
                     categories: "Mansion",
                     owner: user1, post_images: [post_image])

  user2 = User.create!(email: Faker::Internet.email,
                       name: Faker::Name.first_name,
                       password: '123456789',
                       password_confirmation: '123456789')

  Booking.create(user: user2, post: post)

end

