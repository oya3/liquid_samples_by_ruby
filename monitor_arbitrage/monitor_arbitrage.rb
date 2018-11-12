require 'uri'
require 'net/http'
require 'time'
require 'json'
require 'yaml'
require 'pry'

# BTC/JPY
#  "id": "5",
#  "market_ask": 724729.95, # 売値
#  "market_bid": 724684.0, # 買値
#  "last_traded_price": "724735.87"

# QASH/BTC
#  "id": "52",
#  "market_ask": 3.485e-05,
#  "market_bid": 3.45e-05,
#  "last_traded_price": "0.0000345",

# QASH/JPY
#  "id": "50",
#  "market_ask": 25.28,
#  "market_bid": 25.06,
#  "last_traded_price": "25.06",


# URI
uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# PATH
ids = [ 5, 52, 50 ]
results = Array.new
count = 1
while true do
  start_time = Time.now.to_i
  ids.each.with_index(0) do |id,index|
    path = URI.parse("/products/#{id}")
    request = Net::HTTP::Get.new(path.to_s)
    request.add_field('X-Quoine-API-Version', '2')
    response = http.request(request)
    if response.code != '200'
      print "error:#{response}"
      exit
    end
    results[index] = JSON.parse(response.body)
  end
  end_time = Time.now.to_i
  # 1:BTC=QASH:x
  unit = results[0]['last_traded_price'].to_f * results[1]['last_traded_price'].to_f
  
  arbitrage = "[QASH: #{results[2]['last_traded_price'].to_f}, BTC:#{unit}]"
  rate = results[2]['last_traded_price'].to_f / unit
  price = "#{results[0]['last_traded_price']}, #{results[1]['last_traded_price']}, #{results[2]['last_traded_price']}"
  print("#{count}:#{Time.at(start_time)}-#{Time.at(end_time)}: #{rate}: #{arbitrage}: #{price}\n")
  count += 1
  sleep(10) # 1000ms
end
