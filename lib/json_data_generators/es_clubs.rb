require 'httparty'
require 'nokogiri'
require 'json'

url = "https://en.wikipedia.org/wiki/Category:La_Liga_clubs"
page = Nokogiri::HTML(HTTParty.get(url))
hash = {}
page.css('.mw-category-generated .mw-category-group a').each do |node|
  hash["#{node.text}"] = node['href']
end

sorted_hash = hash.sort.to_h

File.open("json_data/es_clubs.json","w") do |f|
  f.write(sorted_hash.to_json)
end








