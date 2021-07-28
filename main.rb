require 'sinatra'
# 再起動を不要にする
require 'sinatra/reloader'
# JSONモジュールを利用する
require 'json'

# コンフィギュレーション: アプリケーションスコープ
configure do
  set :app_title, 'メモアプリ'
  set :json_file, './database.json'
  set :result_hash, []
  # データベースファイルが存在しなければ作成する
  unless File.exist?(settings.json_file)
    File.open(settings.json_file, 'w') {
    }
  end
end

# ヘルパーでエスケープ処理を定義
helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

# get, post, patch, delete の処理: リクエストスコープ
# index表示
get '/' do
  File.open(settings.json_file, 'w') {|file|
    JSON.dump(settings.result_hash, file)
  }
  # データベースファイルが空であれば、メモは1つも表示しない
  unless FileTest.zero?(settings.json_file)
    # ファイルを開き、ファイルオブジェクトを生成する
    File.open(settings.json_file) {|file|
      # JSON形式のファイルオブジェクトを、JSON形式の文字列に変換し、Rubyオブジェクト(ハッシュ）に変換する
      # settingsヘルパーを利用し、リクエストスコープからアプリケーションスコープにアクセス
      settings.result_hash = JSON.parse(file.read, symbolize_names: true)
    }
  end
  erb :index
end

# メモの新規作成
get '/memos/new' do
  erb :new
end

# new表示後、result_hash へinsertし、'/'へリダイレクト
post '/memos/new' do
  # 新しいハッシュを作成し、配列の最後へ挿入する
  hash = {title: "#{h(params[:title])}", body: "#{h(params[:body])}"}
  settings.result_hash.push(hash)
  redirect '/'
end

# 各メモの detail表示
get '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  erb :detail
end

# 各メモの detail 表示後、result_hash から削除し、'/'へリダイレクト
delete '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  # 配列から対象ハッシュを削除する
  settings.result_hash.delete_at(@memo_id)
  redirect '/'
end

# 各メモの detail 表示後、メモ編集用のHTMLフォームを表示
get '/memos/:memo_id/edit' do
  @memo_id = params[:memo_id].to_i
  erb :edit
end

# 各メモの edit 表示後、result_hash を変更し、'/'へリダイレクト
patch '/memos/:memo_id' do
  @memo_id = params[:memo_id].to_i
  # 配列の対象ハッシュを変更する
  settings.result_hash[@memo_id][:title] = "#{h(params[:title])}"
  settings.result_hash[@memo_id][:body] = "#{h(params[:body])}"
  redirect '/'
end

# about表示
get '/about' do
  erb :about
end

# エラーハンドリング
# 未検出(Not Found)
not_found do
  '404エラー：ファイルが存在しません'
end
