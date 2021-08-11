# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
# include ERB::Util
configure do
  set :app_title, 'メモアプリ'
  unless File.exist?('./database.json')
    FileUtils.touch('./database.json')
  end
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class MemoDB
  class << self
    def read_hashes
      hashes = {}
      File.open('./database.json') { |file|
        unless File.zero?('./database.json')
          hashes = JSON.parse(file.read)
        end
      }
      return hashes
    end

    def write_hashes(new_n, memos)
      hashes= {"new_n"=>new_n,"memos"=>memos}
      File.open('./database.json', 'w') { |file|
        JSON.dump(hashes, file)
      }
    end

    def select(memo_id)
      hashes = MemoDB.read_hashes
      return hashes["memos"][memo_id]
    end

    def select_all
      hashes = MemoDB.read_hashes
      memos = {}
      unless hashes.empty?
        memos = hashes["memos"]
      end
      return memos
    end

    def insert(title, body)
      hashes = MemoDB.read_hashes
      new_n = 0
      memos = {}
      unless hashes.empty?
        new_n = hashes["new_n"]
        memos = hashes["memos"]
      end
      memos[new_n + 1] = {"title"=>title, "body"=>body}
      MemoDB.write_hashes(new_n + 1, memos)
    end

    def delete(memo_id)
      hashes = MemoDB.read_hashes
      new_n = hashes["new_n"]
      memos = hashes["memos"]
      memos.delete(memo_id)
      MemoDB.write_hashes(new_n, memos)
    end

    def update(memo_id, title, body)
      hashes = MemoDB.read_hashes
      new_n = hashes["new_n"]
      memos = hashes["memos"]
      memos[memo_id] = {"title"=>title, "body"=>body}
      MemoDB.write_hashes(new_n, memos)
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
