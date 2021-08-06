# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

include ERB::Util

configure do
  set :app_title, 'メモアプリ'
  set :json_file, './database.json'
  set :result_hash, []
  set :reflesh, true
  set :erb, :escape_html => true
  # jsonファイルが存在しなければ、作成する
  unless File.exist?(settings.json_file)
    FileUtils.touch(settings.json_file)
  end
end

get '/' do
  # 再起動後初めての時は、jsonファイルに書き込まない
  unless settings.reflesh
    File.open(settings.json_file, 'w') do |file|
      JSON.dump(settings.result_hash, file)
    end
  end
  settings.reflesh = false
  # データベースファイルが空であれば、メモは1つも画面に表示しない
  unless FileTest.zero?(settings.json_file)
    File.open(settings.json_file) do |file|
      settings.result_hash = JSON.parse(file.read, symbolize_names: true)
    end
  end
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos/new' do
  title = params[:title]
  body = params[:body]
  hash = { title: title, body: body }
  settings.result_hash.push(hash)
  redirect '/'
end

get '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  erb :detail
end

delete '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  settings.result_hash.delete_at(@memo_id)
  redirect '/'
end

get '/memos/:memo_id/edit' do
  @memo_id = params[:memo_id].to_i
  erb :edit
end

patch '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  title = params[:title]
  body = params[:body]
  settings.result_hash[@memo_id][:title] = title
  settings.result_hash[@memo_id][:body] = body
  redirect '/'
end

get '/about' do
  erb :about
end

not_found do
  erb :error
end
