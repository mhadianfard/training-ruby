#!/bin/ruby

require 'net/http'
require 'json'


# Complete the function below.


def getMovieTitles(substr)
  base_url = "https://jsonmock.hackerrank.com/api/movies/search/"
  titles = nil

  page = 1
  item = 0
  loop do
    json = Net::HTTP.get(URI("#{base_url}?Title=#{substr}&page=#{page}"))
    response = OpenStruct.new(JSON.parse(json))
    total = response.total
    total_pages = response.total_pages
    titles = Array.new(total) if titles.nil?
    response.data.each do |movie|
      titles[item] = OpenStruct.new(movie).Title
      item += 1
    end
    page += 1
    break if page > total_pages
  end
  puts titles.inspect
  titles.sort_by { |word| word.downcase }
end

getMovieTitles("spiderman")