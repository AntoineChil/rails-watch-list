require 'json'
require 'rest-client'

puts "Cleaning database..."
# Movie.destroy_all

puts 'Seeding...'
response = RestClient.get 'https://tmdb.lewagon.com/movie/top_rated'
repos = JSON.parse(response)
# => repos is an `Array` of `Hashes`.
puts "Creating movies..."
repos['results'].each do |h|
  movie = Movie.new(
    title: h['title'],
    overview: h['overview'],
    poster_url: "https://image.tmdb.org/t/p#{h['poster_path']}",
    rating: h['vote_average']
  )
  movie.save!
  puts "Created #{movie.title}"
end
puts "Finished!"
