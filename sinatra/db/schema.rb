require 'sequel'
DB = Sequel.connect("sqlite://books.db") # in memory

require_relative '../models/book'
