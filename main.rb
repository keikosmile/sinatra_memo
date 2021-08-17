# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

class MemoDB
  JSON_FILE = './database.json'

  class << self
    def read_data
      data = {}
      data = JSON.parse(File.read(JSON_FILE)) unless File.zero?(JSON_FILE)
      data
    end

    def write_data(new_number, memos)
      data = { 'new_number' => new_number, 'memos' => memos }
      File.open(JSON_FILE, 'w') do |file|
        JSON.dump(data, file)
      end
    end

    def select(memo_id)
      data = MemoDB.read_data
      data['memos'][memo_id]
    end

    def select_all
      data = MemoDB.read_data
      memos = {}
      memos = data['memos'] unless data.empty?
      memos
    end

    def insert(title, body)
      data = MemoDB.read_data
      new_number = 0
      memos = {}
      unless data.empty?
        new_number = data['new_number']
        memos = data['memos']
      end
      memos[new_number + 1] = { 'title' => title, 'body' => body }
      MemoDB.write_data(new_number + 1, memos)
    end

    def delete(memo_id)
      data = MemoDB.read_data
      new_number = data['new_number']
      memos = data['memos']
      memos.delete(memo_id)
      MemoDB.write_data(new_number, memos)
    end

    def update(memo_id, title, body)
      data = MemoDB.read_data
      new_number = data['new_number']
      memos = data['memos']
      memos[memo_id] = { 'title' => title, 'body' => body }
      MemoDB.write_data(new_number, memos)
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

get '/memos/:memo_id' do
  @memo_id = params[:memo_id]
  @memo = MemoDB.select(@memo_id)
  erb :detail
end

delete '/memos/:memo_id' do
  MemoDB.delete(params[:memo_id])
  redirect '/'
end

get '/memos/:memo_id/edit' do
  @memo_id = params[:memo_id]
  @memo = MemoDB.select(@memo_id)
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
