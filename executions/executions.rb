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
path = URI.parse("/executions")
params = { :product_id => 83, :limit => 20, :page => 1 }
path.query = URI.encode_www_form(params)
request = Net::HTTP::Get.new(path.to_s)
response = http.request(request)
if response.code != '200'
  print "error:#{response}"
  exit
end
executions = JSON.parse(response.body)

File.write 'executions.json', executions.to_json
File.write 'executions.yml', executions.to_yaml
