# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

url = "https://www.imdb.com/list/ls062911411/"
html = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')

html.search('.lister-item-content').each do |element|
  Movie.create!(title: element.search("h3 a").text.strip, genre: element.search(".genre").text.strip)
  puts "movie created"
end
