# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require_relative 'memo_db'

configure do
  set :app_title, 'メモアプリ'
  FileUtils.touch(MemoDB::JSON_FILE) unless File.exist?(MemoDB::JSON_FILE)
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  @memos = MemoDB.select_all
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos/new' do
  MemoDB.insert(params[:title], params[:body])
  redirect '/'
end

get '/memos/:id' do
  @id = params[:id]
  @memo = MemoDB.select(@id)
  erb :detail
end

delete '/memos/:id' do
  MemoDB.delete(params[:id])
  redirect '/'
end

get '/memos/:id/edit' do
  @id = params[:id]
  @memo = MemoDB.select(@id)
  erb :edit
end

patch '/memos/:id' do
  MemoDB.update(params[:id], params[:title], params[:body])
  redirect '/'
end

get '/about' do
  erb :about
end

not_found do
  erb :error
end
