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
  @comment = Comment.new
  @comments = Comment.all
  erb :index
end

post '/comments' do
  @comment = Comment.new(title: params[:comment_title], body: params[:comment_body])
  if @comment.save
    redirect '/'
  else
    @comments = Comment.all # [erb :index]で使用しているため、これが無いとエラーになる。
    erb :index
  end
end