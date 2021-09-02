require 'json'
require 'open-uri'

url = "http://www.omdbapi.com/?t=inception&y=2010&apikey=b4c15d98"
movie_url = URI.open(url).read
movie_json = JSON.parse(movie_url)

puts movie_json
puts "__________________________________________________"
puts movie_json["Title"]
puts movie_json["Plot"]
puts movie_json["Year"]
puts movie_json["Genre"]
puts movie_json["Poster"]
