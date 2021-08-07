# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

include ERB::Util

configure do
  set :app_title, 'メモアプリ'
  unless File.exist?('./database.json')
    FileUtils.touch('./database.json')
  end
end

class MemoDB
  class << self
    def read_memos
      memos = {}
      File.open('./database.json') { |file|
        unless File.zero?('./database.json')
          memos = JSON.parse(file.read)
        end
      }
      return memos
    end

    def write_memos(result_hash)
      File.open('./database.json', 'w') { |file|
        JSON.dump(result_hash, file)
      }
    end

    def select(memo_id)
      memos = MemoDB.read_memos
      return memos[memo_id]
    end

    def select_all
      return MemoDB.read_memos
    end

    def insert(title, body)
      memos = MemoDB.read_memos
      memo_id = 0
      unless memos.empty?
        memo_id = memos.keys.max.to_i
      end
      memo_id += 1
      memos[memo_id] = {"title"=>title, "body"=>body}
      MemoDB.write_memos(memos)
    end

    def delete(memo_id)
      memos = MemoDB.read_memos
      memos.delete(memo_id)
      MemoDB.write_memos(memos)
    end

    def update(memo_id, title, body)
      memos = MemoDB.read_memos
      memos[memo_id] = {"title"=>title, "body"=>body}
      MemoDB.write_memos(memos)
    end
  end
end

get '/' do
  @result_hash = MemoDB.select_all
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos/new' do
  MemoDB.insert(params[:title], params[:body])
  redirect '/'
end

get '/memos/:memo_id' do
  @memo_id = params[:memo_id]
  @result_hash = MemoDB.select(@memo_id)
  erb :detail
end

delete '/memos/:memo_id' do
  MemoDB.delete(params[:memo_id])
  redirect '/'
end

get '/memos/:memo_id/edit' do
  @memo_id = params[:memo_id]
  @result_hash = MemoDB.select(@memo_id)
  erb :edit
end

patch '/memos/:memo_id' do
  MemoDB.update(params[:memo_id], params[:title], params[:body])
  redirect '/'
end

get '/about' do
  erb :about
end

not_found do
  erb :error
end
