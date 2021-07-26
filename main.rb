require 'sinatra'
require 'sinatra/reloader'

class Memo
  attr_accessor :title, :content, :date

  def initialize(title, content, date)
    @title = title
    @content = content
    @date = date
  end
end

class MemoDatabase
  attr_accessor :mda

  def initialize
    @mda = []
  end

  def get_memo(id)
    @mda[id]
  end

  def insert(title, content)
    # id は 0 から始まる
    memo = Memo.new(title, content, Time.now)
    @mda.push(memo)
  end

  def edit(id, title, content)
    @mda[id].title = title
    @mda[id].content = content
    @mda[id].date = Time.now
  end

  def delete(id)
    @mda[id].pop
  end
end

# グローバル変数
$title = 'メモアプリ'
# MemoDatabase をインスタン化して、アプリケーションのスコープで保存する
set :md, MemoDatabase.new

# get, post の処理は、リクエストスコープ
# home表示
get '/' do
  erb :home
end

# edit で変更後、home表示
post '/' do
  settings.md.edit(params[:id].to_i, params[:title], params[:content])
  erb :home
end

delete '/' do
  settings.md.delete(params[:id])
  erb :home
end

# new表示
get '/new' do
  erb :new
end

# new表示後、insertし、home表示
post '/new' do
  # settingsヘルパーを利用し、リクエストスコープからアプリケーションスコープにアクセス
  settings.md.insert(params[:title], params[:content])
  erb :home
end

# 各メモ show表示
get '/memos/:id' do
  @id = params[:id].to_i
  erb :show
end

# show表示後、各メモの edit表示
get '/memos/:id/edit' do
  @id = params[:id].to_i
  erb :edit
end

get '/about' do
  erb :about
end
