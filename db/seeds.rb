# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(
#[
#  { name: 'Star Wars' },
#  { name: 'Lord of the Rings' }
#  ]
#)
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

#loading constants
USER_FILE = Rails.root.join('db', 'user_seeds.csv')
puts "Loading raw  data from #{USER_FILE}"

#############################################################
#seeding categories
x = ["accessories", "books", "clothing", "horror", "luggage", "shoes", "tech", "miscellaneous"]
x.each do |category|
  Category.create(category_type: category)
end
##############################################################

##############################################################
#seeding users
user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|

  user = User.new
  user.name = row['name']
  user.nickname = row['nickname']
  user.email = row['email']
  user.image_url = row['image_url']
  user.uid = row['uid']
  user.provider = row['provider']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end
##############################################################
Item.create(name: "Bowsii MJ", description: "A delightfully fancy pair of shoes to wear to your next tea paaarte", price: 60, image: "https://cdn.shopify.com/s/files/1/0758/2735/products/TB1slR3JVXXXXbsXVXXXXXXXXXX__0-item_pic.jpg?v=1534937389", quantity_available: 10, user_id: 1, active: true, category_id: 6)
