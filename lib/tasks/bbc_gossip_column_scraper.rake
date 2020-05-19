require 'httparty'
require 'nokogiri'

URL = 'https://www.bbc.co.uk/sport/football/gossip'

namespace :scrape do
  desc "Scrape the BBC Sport Gossip Column for Rumours"
  task :bbc do
    page = Nokogiri::HTML(HTTParty.get(URL))
    page.css('div#story-body p').each do |story|
      p "*"*100
      p story.text
      p "*"*100
    end
  end
end





