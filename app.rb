require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: 'sqlite3', database: 'bbs_workshop.sqlite3'}

# models
class Comment < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body
end

# endpoints
get '/' do
  @comments = Comment.all
  erb :index
end

post '/comments' do
  @comment_title = params[:comment_title]
  @comment_body = params[:comment_body]

  Comment.create!(title: @comment_title, body: @comment_body)
  redirect '/'
end