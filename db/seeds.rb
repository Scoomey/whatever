# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

url = "https://www.imdb.com/search/title/?count=100&groups=top_1000&sort=user_rating"
html = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')
html.search(".lister-item-content").each do |element|
  title = element.search("h3 a").text.strip
  genre = element.search(".genre").text.strip
  year = element.search(".lister-item-year").text.strip
  year = year[1..4].to_i
  Movie.new(title: title, genre: genre, year: year)
end

foods = ["Pizza", "Curry", "Succhi", " Ramen", "Full English",
         "Mac and Cheese", "Chicken Tikka Masala", "Churros",
         "Mooncake", "Pie and Chips", "Miso Soup", "Jacket Potato",
         "Bruschetta", "Stew", "Pad Thai", "Quesadilla", "Kebab",
         "Fondue", "Fajitas", "Burrito", "Burger and fries", "Panini",
         "Grilled Cheese", "Linguini and clams", "Soufflé",
         "Frozen Yogurt", "Frog legs", "Foie Gras", "Duck",
         "Rice and Peas", "Jerk Chicken", "Satay", "Falafel Wrap",
         "Poutine", "Chips Cheese Curry Sauce", "Pie and Mash",
         "Toad In The Hole", "Spotted Dick", "Haggis",
         "Peri Peri Chicken", "Rogan Josh", "Katsu curry",
         "Spaghetti Bolognese", "Carbonara", "Fettuccine Alfredo",
         "Dal ", "Panna Cotta", "Pulled Pork Sandwich", "Apple Pie",
         "Karē", "Tapas", "Yakisoba", "Pizza Margherita"]

foods.each do |food|
  puts "creating food"
  Food.create!(dish: food)
  puts "finishing food"
end
