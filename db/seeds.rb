# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_movie(browser, movie_name, image_url)
  movie_link = browser.link(text: movie_name)
  movie = Movie.new
  movie.title = movie_name
  movie.thumbnail_url = image_url
  movie_link.click
  page = Nokogiri::HTML.parse(browser.html)
  movie.synopsis = page.at_css('p:nth-child(2)')&.text
  movie.casts = page.at_css('p:nth-child(3)')&.text.sub('Casts: ', '')
  movie.running_time = page.at_css('p:nth-child(4)')&.text.sub('Running time: ', '')
  movie.genres = page.at_css('p:nth-child(5)')&.text.sub('Genre: ', '')
  movie.release_date = page.at_css('p:nth-child(6)')&.text.sub('Release date:', '')
  movie.save!
  browser.back
end

browser = Watir::Browser.new
browser.goto 'https://silverbirdcinemas.com'
html = browser.html
home_page = Nokogiri::HTML.parse(html)
movies = home_page.css('.owl-item')

movie_links = movies.map do |movie|
  next if movie.at_css('img').nil? || movie.css('a').nil?
  [movie.css('a').text, movie.at_css('img').attr('src')]
end

movie_links.each do |movie|
  create_movie browser, movie.first, movie.last
end

# movies.each

=begin
movie_url, title, thumbnail_url, synopsis
=end

