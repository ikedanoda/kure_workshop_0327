require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: 'sqlite3', database: 'bbs_workshop.sqlite3'}

# models
class Comment < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :category_id
end

class Category < ActiveRecord::Base
  has_many :comments
  validates_presence_of :name
end

class User < ActiveRecord::Base
  has_many :comments
  validates_presence_of :last_name
  validates_presence_of :first_name
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
  @comment = Comment.new(
      title: params[:comment_title],
      body: params[:comment_body],
      category_id: params[:comment_category_id],
      user_id: params[:comment_user_id]
  )
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
  if @comment.update(
      title: params[:comment_title],
      body: params[:comment_body],
      category_id: params[:comment_category_id],
      user_id: params[:comment_user_id]
  ) # updateメソッド内でvalidメソッドも動作している
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

## users
get '/users' do
  @users = User.all
  erb :user_index
end

get '/users/new' do
  @user = User.new
  erb :user_new
end

post '/users' do
  @user = User.new(last_name: params[:user_last_name], first_name: params[:user_first_name])
  if @user.save
    redirect '/users'
  else
    erb :user_new
  end
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :user_edit
end

post '/users/:id/update' do
  @user = User.find(params[:id])
  if @user.update(last_name: params[:user_last_name], first_name: params[:user_first_name])
    redirect '/users'
  else
    erb :user_edit
  end
end

post '/users/:id/delete' do
  @user = User.find(params[:id])
  @user.destroy!
  redirect '/users'
end
