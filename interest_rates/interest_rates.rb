require 'uri'
require 'net/http'
require 'time'
require 'json'
require 'yaml'
require 'pry'

# URI
uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# PATH
currency_name = 'USD'
path = URI.parse("/ir_ladders/#{currency_name}")
request = Net::HTTP::Get.new(path.to_s)
request.add_field('X-Quoine-API-Version', '2')
response = http.request(request)
if response.code != '200'
  print "error:#{response}"
  exit
end
interest_rates = JSON.parse(response.body)
File.write 'interest_rates.json', JSON.pretty_generate(interest_rates)
File.write 'interest_rates.yml', interest_rates.to_yaml
