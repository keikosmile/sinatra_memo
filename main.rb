require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @title = 'メモアプリ'
  @memo_num = 5
  erb :home
end

post '/' do
  @title = 'メモアプリ'
  @memo_num = 5
  erb :home
end

put '/' do
  @title = 'メモアプリ'
  @memo_num = 5
  erb :home
end

get '/new' do
  @title = 'メモアプリ'
  erb :new
end

get '/memos/:id' do
  @id = params[:id]
  @title = 'メモアプリ'
  erb :show
end

get '/memos/:id/edit' do
  @id = params[:id]
  @title = 'メモアプリ'
  erb :edit
end

post '/memos/:id/delete' do
  @id = params[:id]
  @title = 'メモアプリ'
  @memo_num = 5
  erb :home
end

get '/about' do
  @title = 'メモアプリ'
  erb :about
end
