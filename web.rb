require 'sinatra'
require 'sinatra/reloader'
require "sinatra/json"
require 'erb'
require 'open-uri'
require 'json'

get '/' do
  erb :index
end

