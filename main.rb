require 'sinatra'
# 再起動を不要にする
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

# メモのnew表示
get '/new' do
  erb :new
end

# new表示後、DBへinsertし、'/'へリダイレクト
post '/new' do
  # settingsヘルパーを利用し、リクエストスコープからアプリケーションスコープにアクセス
  settings.md.insert(params[:title], params[:content])
  redirect '/'
end

# 各メモのshow表示
get '/memos/:id' do
  @id = params[:id].to_i
  erb :show
end

# 各メモのshow表示後、DBを削除し、'/'へリダイレクト
delete '/memos/:id' do
  @id = params[:id].to_i
  settings.md.delete(@id)
  redirect '/'
end

# 各メモのshow表示後、edit表示
get '/memos/:id/edit' do
  @id = params[:id].to_i
  erb :edit
end

# 各メモのedit表示で変更後、DBを変更し、'/'へリダイレクト
post '/memos/:id/edit' do
  @id = params[:id].to_i
  settings.md.edit(@id, params[:title], params[:content])
  redirect '/'
end

# about表示
get '/about' do
  erb :about
end
