require 'sinatra'
require 'sinatra/reloader'
require "sinatra/json"
require 'erb'
require 'open-uri'
require 'json'

get '/' do
  #  インスタンス変数で渡す
  @bar = "bar"
  # ローカル変数として渡す
  erb :index, :locals => {:foo  => 'foo'} 
end

#  複数ルートで同一動作
['/one', '/two', '/three'].each do |route|
  get route do
    "Triggered #{route} via GET"
  end

  post route do
    "Triggered #{route} via POST"
  end
end

post '/login' do
  # POSTのパラメータはparamsでとれる
  username = params[:username]
  password = params[:password]
end

get '/name/:name' do
  # /name/some_name?foo=XYZ形式をとる
  "You asked for #{params[:name]} as well as #{params[:foo]}"
end

# 正規表現ありのroute
get %r{/(sp|gr)eedy} do
  "You got caught in the greedy route!"
end
