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
# params = { :product_id => 83, :limit => 20, :timestamp => Time.now.to_i }
# - RubyとRailsにおけるTime, Date, DateTime, TimeWithZoneの違い
#   https://qiita.com/jnchito/items/cae89ee43c30f5d6fa2c
# - RubyでUNIXTIME変換
#   https://qiita.com/mogulla3/items/195ae5d8ad574dfc6baa
params = { :product_id => 83, :limit => 20, :timestamp => Time.parse('2018-11-01 00:00:00').to_i }
path.query = URI.encode_www_form(params)
request = Net::HTTP::Get.new(path.to_s)
response = http.request(request)
if response.code != '200'
  print "error:#{response}"
  exit
end
executions = JSON.parse(response.body)

File.write 'executions_for_timestamp.json', executions.to_json
File.write 'executions_for_timestamp.yml', executions.to_yaml
