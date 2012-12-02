# -*- coding: utf-8 -*-

require 'twitter'
require 'oauth'
#require './oauth-patch' # Ruby1.9の場合必要
require 'json'

CONSUMER_KEY = '****'
CONSUMER_SECRET = '****'
ACCESS_TOKEN = "****"
ACCESS_TOKEN_SECRET = "****"

#consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => 'https://api.twitter.com', :oauth_version => '1.1')
#access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
#p access_token

# oauth認証
Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = ACCESS_TOKEN
  config.oauth_token_secret = ACCESS_TOKEN_SECRET
end

# タイムラインを取得して時系列順に表示
#Twitter.update("hoge")

#p Twitter.home_timeline
#Twitter.mentions.each do |men|
#  puts men.text
#end

#自分のつぶやき最新10件
options = {"count" => 10}
#Twitter.home_timeline("kaisou_test", options).each do |res|
#Twitter.home_timeline.each do |res|
#  p "#{res.from_user}: #{res.text}"
#end
