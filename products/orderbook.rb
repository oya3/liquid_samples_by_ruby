require 'uri'
require 'net/http'
require 'time'
require 'json'
require 'yaml'
require 'pry'

uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

id = 83 # id を指定
orderbook_response = http.request(Net::HTTP::Get.new("/products/#{id}/price_levels"))
if orderbook_response.code != '200'
  print "error:#{orderbook_response}"
  exit
end
orderbook = JSON.parse(orderbook_response.body)
File.write 'orderbook.json', orderbook.to_json
File.write 'orderbook.yml', orderbook.to_yaml
