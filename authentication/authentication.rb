require 'uri'
require 'net/http'
require 'time'
require 'jwt'
require 'yaml'
require 'pry'

uri = URI.parse("https://api.liquid.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# [../user_info.yml]
# user_info:
#   token_id = 'トークンID'
#   user_secret = 'シークレットキー'

user_info = YAML.load_file("../user_info.yml")['user_info']
path = '/orders?product_id=1'

auth_payload = {
  path: path,
  nonce: DateTime.now.strftime('%Q'),
  token_id: user_info['token_id']
}

signature = JWT.encode(auth_payload, user_info['user_secret'], 'HS256')

request = Net::HTTP::Get.new(path)
request.add_field('X-Quoine-API-Version', '2')
request.add_field('X-Quoine-Auth', signature)
request.add_field('Content-Type', 'application/json')

response = http.request(request)
binding.pry
