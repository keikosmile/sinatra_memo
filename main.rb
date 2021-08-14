# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

class MemoDB
  JSON_FILE = './database.json'

  class << self
    def read_hashes
      hashes = {}
      File.open(JSON_FILE) do |file|
        hashes = JSON.parse(file.read) unless File.zero?(JSON_FILE)
      end
      hashes
    end

    def write_hashes(new_n, memos)
      hashes = { 'new_n' => new_n, 'memos' => memos }
      File.open(JSON_FILE, 'w') do |file|
        JSON.dump(hashes, file)
      end
    end

    def select(memo_id)
      hashes = MemoDB.read_hashes
      hashes['memos'][memo_id]
    end

    def select_all
      hashes = MemoDB.read_hashes
      memos = {}
      memos = hashes['memos'] unless hashes.empty?
      memos
    end

    def insert(title, body)
      hashes = MemoDB.read_hashes
      new_n = 0
      memos = {}
      unless hashes.empty?
        new_n = hashes['new_n']
        memos = hashes['memos']
      end
      memos[new_n + 1] = { 'title' => title, 'body' => body }
      MemoDB.write_hashes(new_n + 1, memos)
    end

    def delete(memo_id)
      hashes = MemoDB.read_hashes
      new_n = hashes['new_n']
      memos = hashes['memos']
      memos.delete(memo_id)
      MemoDB.write_hashes(new_n, memos)
    end

    def update(memo_id, title, body)
      hashes = MemoDB.read_hashes
      new_n = hashes['new_n']
      memos = hashes['memos']
      memos[memo_id] = { 'title' => title, 'body' => body }
      MemoDB.write_hashes(new_n, memos)
    end
  end
end

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
