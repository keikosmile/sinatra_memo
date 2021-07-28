require 'sinatra'
# 再起動を不要にする
require 'sinatra/reloader'
# JSONモジュールを利用する
require 'json'

# グローバル変数
$application_title = 'メモアプリ'
$database_file = './database.json'

# コンフィギュレーション: アプリケーションスコープ
configure do
  set :result_hash, []
  # データベースファイルが存在しなければ作成する
  unless File.exist?($database_file)
    File.open($database_file, 'w') {
    }
  end
end

# get, post の処理: リクエストスコープ
# index表示
get '/' do
  # 初めて起動した時、result_hash = []
  # データ操作した後、result_hash = [] or != []
  if !settings.result_hash.empty?
    # データベースファイルへ書き込む
    File.open($database_file, 'w') {|file|
      JSON.dump(settings.result_hash, file)
    }
  end
  # データベースファイルが空でなければ、それぞれのメモを表示する
  # データベースファイルが空であれば、メモは1つも表示しない
  unless FileTest.zero?($database_file)
    # ファイルを開き、ファイルオブジェクトを生成する
    File.open($database_file) {|file|
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
  hash = {title: params[:title], body: params[:body]}
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
  settings.result_hash[@memo_id][:title] = params[:title]
  settings.result_hash[@memo_id][:body] = params[:body]
  redirect '/'
end

# about表示
get '/about' do
  erb :about
end
