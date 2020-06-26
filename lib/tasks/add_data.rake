require 'httparty'
require 'nokogiri'
require 'json'

namespace :add_data do
  desc "Scrape Wikipedia for a EPL players & clubs"
  task :epl => :environment do
    EPL_CLUBS.each do |club|
      club_name = club[:name]
      club_path = club[:path]
      url = "https://en.wikipedia.org/wiki/#{club_path}"
      page = Nokogiri::HTML(HTTParty.get(url))
      page.css('tbody tr.vcard.agent span.fn a').each do |player|
        club = Club.find_or_create_by(name: club_name, path: url)
        player = Player.create(name: player.text, club_id: club.id)
        p "Successfully created #{player.name} at #{club.name}"
      end
      sleep 2
    end
  end

  desc "Add english league clubs"
  task :en_league_clubs => :environment do
    club_hash = JSON.parse(File.read("./json_data/en_league_clubs.json"))
    club_hash.each do |club|
      name = club.first
      url = club.last
      club = Club.find_or_create_by(name: name, path: url)
      p "Successfully created #{club.name}"
    end
    sleep 2
  end

  desc "Add Bundesliga players & clubs"
  task :bundesliga => :environment do
    club_hash = JSON.parse(File.read("./json_data/de_clubs.json"))
    club_hash.each do |club|
      name = club.first
      url = club.last
      club = Club.find_or_create_by(name: name, path: url)
      p "Successfully created #{club.name}"
    end
    sleep 2
  end
end





