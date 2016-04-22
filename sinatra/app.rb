require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require_relative 'db/schema'

set :bind, '0.0.0.0'
enable :sessions
set :session_secret, '864505254583cc54fc29d8c1f4c00510'


get '/' do
  @books = Book.all
  erb :index
end
