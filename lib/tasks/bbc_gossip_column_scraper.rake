require 'httparty'
require 'nokogiri'

# "Chelsea are considering switching their attentions to signing RB Leipzig striker Timo Werner, 24, if the Germany international indicates a willingness to move. (ESPN)"

URL = 'https://www.bbc.co.uk/sport/football/gossip'

namespace :scrape do
  desc "Scrape the BBC Sport Gossip Column for Rumours"
  task :bbc => :environment do
    page = Nokogiri::HTML(HTTParty.get(URL))
    page.css('div#story-body p').each.with_index do |story, index|
      next if index > 0
      if story.text.match(/transfer/i) || story.text.match(/signing/i) || story.text.match(/move/i)
        keywords = story.text.scan(/\b[A-Z].*?\b/)
        potential_subjects = []
        p keywords
        keywords.each do |keyword|
          # get the subject player
          next unless Player.where(['name LIKE ?', "%#{keyword}%"]).exists?
          subject = Player.where(['name LIKE ?', "%#{keyword}%"]).first
          potential_subjects << subject.id
        end

        next unless Player.find(potential_subjects).count == 1
        subject = Player.find(potential_subjects).first


        # get the target clubs
        keywords.each do |keyword|
          next unless Club.where(['name LIKE ?', "%#{keyword}%"]).exists?
          target = Club.where(['name LIKE ?', "%#{keyword}%"]).first
          next if subject.plays_for_club?(target) # we don't want to link a player with their existing club!
          next if subject.already_linked_with_club?(target) # the player and club have already got a Rumour
          rumour = Rumour.create(player_id: subject.id, club_id: target.id, source_id: 1, description: story.text) # BBC Gossip Column
        end
      end
    end
  end
end





