require 'uri'
require 'net/http'
require 'time'
require 'json'
require 'yaml'
require 'pry'

uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

products_response = http.request(Net::HTTP::Get.new('/products'))
if products_response.code != '200'
  print "error:#{products_response}"
  exit
end
products = JSON.parse(products_response.body)
File.write 'products.json', products.to_json
File.write 'products.yml', products.to_yaml
