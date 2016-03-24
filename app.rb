require 'rubygems'
require 'bundler'

Bundler.require

get '/' do
  @now = Time.now
  erb :index
end