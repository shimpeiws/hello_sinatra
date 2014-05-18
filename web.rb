require 'sinatra'
require 'sinatra/reloader'
require "sinatra/json"
get '/' do
  'Hello world!(restart)'
end

get '/param/:id' do
  "param test [id = #{params[:id]}]"
end

get '/api' do
  data = { foo: "bar" }
  json data
end

