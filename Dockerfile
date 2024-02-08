#Dockerイメージの選択
FROM ruby:3.0.4
#
RUN apt-get update -qq
#HTTPリクエストを送るcommand
#nodejsのパッケージマネージャ（NVM）とnodejsをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
#yarnをインストール
RUN npm install --global yarn
#作業ディレクトリを指定
WORKDIR /samplerails
#ホストマシンにあるGemfile Gemfile.lockをコピー
COPY Gemfile Gemfile.lock /samplerails/ 
#RubyのGemをインストール
#初めのGemfileはrailsのインストールのみを記述している
#その後上書きされて必要なGemが記述される
RUN bundle install
#railsサーバー起動
#0.0.0.0で外部からのアクセスを可能にしている
CMD ["rails", "server", "-b", "0.0.0.0"]
