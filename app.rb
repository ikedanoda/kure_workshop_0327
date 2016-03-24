require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: 'sqlite3', database: 'bbs_workshop.sqlite3'}

# models
class Comment < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :body
end


class Category < ActiveRecord::Base
  validates_presence_of :name
end

# endpoints
## top
get '/' do
  @comment = Comment.new
  @comments = Comment.all
  erb :index
end

## comments
post '/comments' do
  @comment = Comment.new(title: params[:comment_title], body: params[:comment_body])
  if @comment.save # saveメソッド内でvalidメソッドも動作している
    redirect '/'
  else
    @comments = Comment.all # [erb :index]で使用しているため、これが無いとエラーになる。
    erb :index
  end
end

get '/comments/:id/edit' do
  @comment = Comment.find(params[:id])
  erb :comment_edit
end

post '/comments/:id/update' do
  @comment = Comment.find(params[:id])
  if @comment.update(title: params[:comment_title], body: params[:comment_body]) # updateメソッド内でvalidメソッドも動作している
    redirect '/'
  else
    erb :comment_edit
  end
end

post '/comments/:id/delete' do
  @comment = Comment.find(params[:id])
  @comment.destroy!
  redirect '/'
end

## categories
get '/categories' do
  @categories = Category.all
  erb :category_index
end

get '/categories/new' do
  @category = Category.new
  erb :category_new
end

post '/categories' do
  @category = Category.new(name: params[:category_name])
  if @category.save
    redirect '/categories'
  else
    erb :category_new
  end
end

get '/categories/:id/edit' do
  @category = Category.find(params[:id])
  erb :category_edit
end

post '/categories/:id/update' do
  @category = Category.find(params[:id])
  if @category.update(name: params[:category_name])
    redirect '/categories'
  else
    erb :category_edit
  end
end

post '/categories/:id/delete' do
  @category = Category.find(params[:id])
  @category.destroy!
  redirect '/categories'
end
