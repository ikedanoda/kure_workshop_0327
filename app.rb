require 'rubygems'
require 'bundler'

Bundler.require

get '/' do
  erb :index
end

post '/comments' do
  @comment_title = params[:comment_title]
  @comment_body = params[:comment_body]
  erb :comment_confirm
end