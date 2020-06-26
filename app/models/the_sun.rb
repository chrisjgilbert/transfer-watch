require 'httparty'
require 'nokogiri'
require 'google/cloud/language'

class TheSun
  def initialize
    @url = 'https://www.thesun.co.uk/sport/football/transfer-news/'
  end

  def language
    Google::Cloud::Language.language_service
  end

  def sanitize_text(story)
    story.text.gsub(/[^0-9A-Za-z.\-]/, ' ')
  end
  
  def scrape
    page = Nokogiri::HTML(HTTParty.get(@url))

    page.css('#main-content a').each do |story|
      next if story.blank?
      story = sanitize_text(story)
      if story.match(/transfer/i) || story.match(/signing/i) || story.match(/move/i) || story.match(/signing/i)

        # call Google's API
        document = { content: story, type: :PLAIN_TEXT }
        response = language.analyze_entities document: document
        entities = response.entities

        # Extract the player and clubs from Google response
        players = []
        clubs = []
        entities.each do |entity|
          if entity.type == :PERSON
            player = Player.find_by(name: entity.name)
            unless player.nil?
              players << player
            end
          end

          # matching Based on Wikiepdia URL seems more reliable than entity.type == :ORGANIZATION
          # and then looking up the name in our DB
          entity_url = entity.metadata['wikipedia_url']
          if Club.where(path: entity_url).exists?
            club = Club.find_by(path: entity_url)
            clubs << club
          end   
        end
        
        p players
        p clubs
        # this means we will ignore stories with
        # multiple players (for now)
        # and also skip if we don't find any
        # players
        next unless players.length == 1
        next unless clubs.length > 0

        matched_player = players.first
        clubs.each do |linked_club|
          next if matched_player.plays_for_club?(linked_club) || matched_player.already_linked_with_club?(linked_club)
          rumour = Rumour.new(description: story, player_id: matched_player.id, club_id: linked_club.id)
          p "*"*100
          p "From the text: #{story}"
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

