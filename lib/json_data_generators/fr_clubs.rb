require 'httparty'
require 'nokogiri'
require 'json'

url = "https://en.wikipedia.org/wiki/Ligue_1"
page = Nokogiri::HTML(HTTParty.get(url))
hash = {}
page.xpath('//table[3]//tbody').css('a').each do |node|
  hash["#{node.text}"] = node['href']
end

sorted_hash = hash.sort.to_h

p sorted_hash

File.open("json_data/fr_clubs.json","w") do |f|
  f.write(sorted_hash.to_json)
end








