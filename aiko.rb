# coding: utf-8
# csvファイルから読み込んでDB登録
require 'csv'
require 'net/http'
require 'uri'
require 'json'

# 元データCSVから読み込み
csv_data = CSV.read('aiko.csv', headers: false)
puts "csv data read complete"

# cloudantの設定
cloudant_url =  "cloudant_address"
uri = URI.parse(cloudant_url)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true

req = Net::HTTP::Post.new(uri.request_uri)
req['Content-Type'] = "application/json"

# CSVの1行ごとに登録
csv_data.each do |data|
  payload = {
    "_id" => data[0],
    "song_name" =>  data[1]
  }.to_json
  req.body = payload
  res = https.request(req)
    
  puts "#{data[0]} is #{data[1]}"
  puts "code -> #{res.code}"
  puts "msg -> #{res.message}"
end
    
