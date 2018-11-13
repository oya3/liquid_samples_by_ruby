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
path = URI.parse("/products")
request = Net::HTTP::Get.new(path.to_s)
request.add_field('X-Quoine-API-Version', '2')
response = http.request(request)
if response.code != '200'
  print "error:#{response}"
  exit
end
products = JSON.parse(response.body)

# (1) JPY で購入できるコイン検索
coin_infos = Hash.new
pair_products = Hash.new
products.each do |product|
  next if product["volume_24h"] == "0.0" # 日本からの取引が24時間ない場合は取扱対象外とする
  
  currency_pair_code = product['currency_pair_code']
  if pair_products.has_key? currency_pair_code
    print "ERROR: multiple currency_pair_code. [#{currency_pair_code}]\n"
    next
  end
  pair_products[currency_pair_code] = product.clone # currency_pair_code 別 porducts に詰める
  
  next if product["quoted_currency"] != 'JPY'
  base_currency = product['base_currency']
  if coin_infos.has_key? base_currency
    print "ERROR: multiple base_currency. [#{base_currency}]\n"
    next
  end
  coin_infos[base_currency] = Hash.new
  coin_infos[base_currency]['product_id'] = product['id']
  coin_infos[base_currency]['pair_products'] = Array.new
end

coin_infos.each do |name1, info|
  coin_infos.each_key do |name2|
    next if name1 == name2
    currency_pair_code = "#{name2}#{name1}"
    next if not pair_products.has_key? currency_pair_code
    pair_product = pair_products[currency_pair_code]
    product = {
      'product_id' => pair_product['id'],
      'currency_pair_code' => pair_product['currency_pair_code'],
      'base_currency' => pair_product['base_currency']
    }
    info['pair_products'] << product
  end
end
  
print JSON.pretty_generate(coin_infos) + "\n"
coin_infos.each do |name1,info|
  info['pair_products'].each do |info2|
    print 'JPY-' + name1 + '-' + info2['base_currency'] + "\n"
  end
end
