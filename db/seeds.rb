# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#user = CreateAdminService.new.call

require 'faker'

number_of_users = 100
number_of_posts_per_user = 10

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

if ActiveRecord::Base.connection.class.name.include?("SQLite3Adapter")
  sql_function_random = "RANDOM()"
else
  sql_function_random = "RAND()"
end

count = 0
userid = 0

begin
  mutex = SeedMutex.create(acquired: true)
rescue ActiveRecord::RecordNotUnique
  mutex = nil
end

number_of_users.times do |i|
  if User.count < number_of_users
    if (userid < 100 and mutex)
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
  end
  if Post.count < (number_of_users * number_of_posts_per_user)
    image = File.open(Dir['app/assets/images/*.png'].sample)
    number_of_posts_per_user.times do |j|
      post_image = PostImage.create(image: image)
      post = Post.create(name: "Post ##{count}",
                         description: Faker::Lorem.paragraph,
                         price: rand_in_range(100, 1),
                         availability: rand_time(5.days.from_now),
                         created_at: rand_time(2.days.ago),
                         updated_at: rand_time(1.days.ago),
                         restrictions: Faker::Lorem.paragraph,
                         categories: "Mansion",
                         owner: user,
                         post_images: [post_image])
      count = count + 1
    end
  end
  #inlined version of Post.book method, because I cannot call the method here
  if i % 10 == 0
    post = Post.all.limit(1).order(sql_function_random).take
    user = User.all.limit(1).order(sql_function_random).take
    money = Transaction.create(price: post.price)
    booking = Booking.create(user_id: user.id, transaction_id: money.id, post_id: post.id)
  end
end
