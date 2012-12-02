# -*- coding: utf-8 -*-

require 'twitter'
require 'oauth'
require 'net/https'

CONSUMER_KEY = '****'
CONSUMER_SECRET = '****'
ACCESS_TOKEN = "****"
ACCESS_TOKEN_SECRET = "****"

consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => 'http://twitter.com'
)

access_token = OAuth::AccessToken.new(
  consumer,
  ACCESS_TOKEN,
  ACCESS_TOKEN_SECRET
)

#uri = URI.parse("https://api.twitter.com/1.1/users/profile_image?screen_name=kaisou_test")
uri = URI.parse("https://api.twitter.com/1.1/statuses/mentions_timeline.json")

https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
https.ca_file = './verisign.cer' # SSL証明書のパスを書く
https.verify_mode = OpenSSL::SSL::VERIFY_PEER
https.verify_depth = 5

buf = ""
https.start do |https|
  request = Net::HTTP::Get.new(uri.request_uri)
  request.oauth!(https, consumer, access_token) # OAuthで認証
  https.request(request) do |response|
    response.read_body do |chunk|
      buf = chunk.split(",")
      buf.each do |strs|
        puts strs
      end
#     chunk.each_key do |key|
#      p key
#     end
    end
  end
end

