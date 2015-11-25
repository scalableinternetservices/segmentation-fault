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

count = 0
userid = 0

begin
  mutex = SeedMutex.create(acquired: true)
rescue ActiveRecord::RecordNotUnique
  mutex = nil
end

if mutex
1000.times do |i|

  # seeding posts

  image = File.open(Dir['app/assets/images/*.png'].sample)
  post_image = PostImage.create(image: image)

  if (userid < 100)
    user = User.create!(email: userid.to_s + "@test.com",
                        name: userid,
                        password: '123456789',
                        password_confirmation: '123456789')

    userid = userid + 1
  else
    user = User.create!(email: Faker::Internet.email,
                        name: Faker::Name.first_name,
                        password: '123456789',
                        password_confirmation: '123456789')
  end

  post = Post.create(name: "Post ##{count}",
                     description: Faker::Lorem.paragraph,
                     price: rand_in_range(100, 1),
                     availability: rand_time(5.days.from_now),
                     created_at: rand_time(2.days.ago),
                     updated_at: rand_time(1.days.ago),
                     restrictions: Faker::Lorem.paragraph,
                     categories: "Mansion",
                     owner: user, post_images: [post_image])

  count = count + 1

  9.times do |j|

    post = Post.create(name: "Post ##{count}",
                       description: Faker::Lorem.paragraph,
                       price: rand_in_range(100, 1),
                       availability: rand_time(5.days.from_now),
                       created_at: rand_time(2.days.ago),
                       updated_at: rand_time(1.days.ago),
                       restrictions: Faker::Lorem.paragraph,
                       categories: "Mansion",
                       owner: user, post_images: [post_image])

    count = count + 1

  end

  #inlined version of Post.book method, because I cannot call the method here

  if (i % 10 == 0)

    money = Transaction.create(price: post.price)
    booking = Booking.create(user_id: user.id, transaction_id: money.id, post_id: post.id)

  end

end
end
