# sinatra_memo メモアプリ

# ローカルで メモアプリ を立ち上げるための手順

## 1. ファイルをダウンロード
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

## 2. gem のインストール
`bundle install`

## 3. アプリケーションの起動
`bundle exec ruby main.rb`

## 4. ブラウザで下記にアクセス
`http://localhost:4567`

## 5. 実行中のアプリケーションを止める
コンソールから`Ctrl+C`
