# db/seeds.rb

require 'faker'

puts "Seeding started..."

# 1. Create 4 Categories
categories = [
  { name: 'Electronics', description: 'Devices and gadgets' },
  { name: 'Clothing', description: 'Apparel and accessories' },
  { name: 'Home & Kitchen', description: 'Furniture and appliances' },
  { name: 'Books', description: 'Educational and entertainment books' }
]

categories.each do |category|
    Category.find_or_create_by!(name: category[:name]) do |cat|
      cat.description = category[:description]
    end
  end

puts "4 categories created."

# 2. Create 10 Users
10.times do
  Admin.create!(
    username: Faker::Internet.username,
   
    password_digest: Faker::Internet.password(min_length: 8), 

   
  )
end

puts "10 users created."

# 3. Create 130 Products
category_ids = Category.pluck(:id)

130.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 10),
    price: Faker::Commerce.price(range: 5.0..500.0),
    on_sale: [true, false].sample,
    new_arrival: [true, false].sample,
    category_id: category_ids.sample
  )
end

puts "130 products created."

puts "Seeding finished successfully! 🌱"
