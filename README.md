# sinatra_memo メモアプリ

# ローカルで メモアプリ を立ち上げるための手順

## 1. ファイルをダウンロードする
### ファイル構成
- views/
  - about.erb
  - edit.erb
  - home.erb
  - layout.erb
  - new.erb
  - show.erb
- .gitignore
- Gemfile
- main.rb
- README.md

## 2. gem をインストールする
`bundle install`

## 3. Webアプリケーションを起動する
`bundle exec ruby main.rb`

## 4. ブラウザで下記にアクセスする
http://localhost:4567

## 5. 実行中のWebアプリケーションを停止する
ターミナルで、Ctrl-C
