require 'sinatra'
require 'sinatra/reloader'
require "sinatra/json"
require 'erb'
require 'open-uri'
require 'json'
require 'active_record'
require 'mysql2'

# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(:development)

class Topic < ActiveRecord::Base
end

# 最新トピック10件分を取得
get '/topics.json' do
  content_type :json, :charset => 'utf-8'
  topics = Topic.order("created_at DESC").limit(10)
  topics.to_json(:root => false)
end

# beforeフィルタ
before do
  @in_before_filter = "before filter"
end

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

# リダイレクト
get '/redirect' do
  redirect 'http://www.google.com'
end

# views配下のサブフォルダも指定可能
get '/views_sub' do
  erb '/user/profile'.to_sym
end
