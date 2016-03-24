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
  Comment.create!(title: params[:comment_title], body: params[:comment_body])
  redirect '/'
end

get '/comments/:id/edit' do
  @comment = Comment.find(params[:id])
  erb :comment_edit
end

post '/comments/:id/update' do
  @comment = Comment.find(params[:id])
  @comment.update!(title: params[:comment_title], body: params[:comment_body])
  redirect '/'
end

post '/comments/:id/delete' do
  @comment = Comment.find(params[:id])
  @comment.destroy!
  redirect '/'
end
