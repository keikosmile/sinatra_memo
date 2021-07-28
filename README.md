# sinatra_memo メモアプリ

# ローカルで メモアプリ を立ち上げるための手順

## 1. ファイルをダウンロードする
### ファイル構成
- public/
  - style.css
- views/
  - about.erb
  - detail.erb
  - edit.erb
  - index.erb
  - layout.erb
  - new.erb
- .gitignore
- database.json (初めてWebアプリケーションを実行後、作成される)
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
