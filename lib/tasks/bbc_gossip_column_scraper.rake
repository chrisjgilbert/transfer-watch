require 'httparty'
require 'nokogiri'
require "google/cloud/language"

URL = 'https://www.bbc.co.uk/sport/football/gossip'

namespace :scrape do
  desc "Scrape the BBC Sport Gossip Column for Rumours"
  task :bbc => :environment do
    language = Google::Cloud::Language.language_service
    page = Nokogiri::HTML(HTTParty.get(URL))
    page.css('div#story-body p').each do |story|

      if story.text.match(/transfer/i) || story.text.match(/signing/i) || story.text.match(/move/i)
        document = { content: story.text, type: :PLAIN_TEXT }
        response = language.analyze_entities document: document

        # Get document sentiment from response
        entities = response.entities
        players = []
        clubs = []

        # Extract the player and clubs from Google response
        entities.each do |entity|
          if entity.type == :ORGANIZATION
            clubs << entity.name
          end
          if entity.type == :PERSON
            players << entity.name
          end          
        end

        # this means we will ignore stories with
        # multiple players (for now)
        # and also skip if we don't find any
        # players
        next unless players.length == 1
        next unless clubs.length > 0

        matched_player = Player.find_by(name: players.first)

        next if matched_player.nil?

        matched_clubs = []
        clubs.each do |club|
          if Club.find_by(name: club).present?
            matched_clubs << Club.find_by(name: club)
          end
        end

        matched_clubs.each do |linked_club|
          next if matched_player.plays_for_club?(linked_club) || matched_player.already_linked_with_club?(linked_club)
          rumour = Rumour.new(description: story.text, player_id: matched_player.id, club_id: linked_club.id)
          p "*"*100
          p "From the text: #{story.text}"
          if rumour.save 
            p "Successfully created a rumour linking #{matched_player.name} with #{linked_club.name}!"
          else
            p "Failed to create rumour linking #{matched_player.name} with #{linked_club.name}!"
          end
          p "*"*100
        end
      end
    end
  end
end





