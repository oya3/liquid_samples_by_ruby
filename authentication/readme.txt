# ユーザ情報ファイルを作成する
$ emacs ../user_info.yml
# user_info:
#  token_id: トークンID
#  user_secret: シークレットキー

# gem をインストールする
$ bundle install --path vendor/bundle

# 認証処理を実行する
$ bundle exec ruby authentication.rb
