require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: 'sqlite3', database: 'bbs_workshop.sqlite3'}

get '/' do
  erb :index
end

post '/comments' do
  @comment_title = params[:comment_title]
  @comment_body = params[:comment_body]
  erb :comment_confirm
end