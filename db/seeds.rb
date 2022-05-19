# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
puts "Cleaning up database..."
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all
puts "Database cleaned"
list_all = List.create(name: "favoritos")
bookmark = Bookmark.new(comment: "excelent")
bookmark.list = list_all
url = "http://tmdb.lewagon.com/movie/top_rated"
movies = JSON.parse(URI.open(url).read)['results']
movies.each do |movie|
  puts "Creating #{movie['title']}"
  base_poster_url = "https://image.tmdb.org/t/p/original"
  film = Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
    rating: movie['vote_average']
  )
  bookmark.movie = film
end
bookmark.save
