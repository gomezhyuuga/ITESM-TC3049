require 'csv'
require_relative 'schema'
require_relative '../models/book'

# Clean
Book.dataset.delete

data = CSV.read("db/books.csv")
data.shift
data.each do |r|
  puts "Creating book..."
  Book.create(title: r[0],
              author: r[1],
              isbn: r[2],
              summary: r[3])
end
