require 'uri'
require 'net/http'
require 'time'
require 'json'
require 'yaml'
require 'pry'

uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

id = 363 # id を指定
product_response = http.request(Net::HTTP::Get.new("/products/#{id}"))
if product_response.code != '200'
  print "error:#{product_response}"
  exit
end
product = JSON.parse(product_response.body)
File.write 'product.json', product.to_json
File.write 'product.yml', product.to_yaml
