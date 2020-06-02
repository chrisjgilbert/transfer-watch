require 'httparty'
require 'nokogiri'

CLUBS =[
  {name: 'Chelsea', path: 'Chelsea_F.C.'},
  {name: 'Arsenal', path: 'Arsenal_F.C.'},
  {name: 'Manchester City', path: 'Manchester_City_F.C.'},
  {name: 'Manchester United', path: 'Arsenal_F.C.'},
  {name: 'Leicester', path: 'Leicester_City_F.C.'},
  {name: 'Liverpool', path: 'Liverpool_F.C.'},
  {name: 'Wolves', path: 'Wolverhampton_Wanderers_F.C.'},
  {name: 'Sheffield United', path: 'Sheffield_United_F.C.'},
  {name: 'Tottenham', path: 'Tottenham_Hotspur_F.C.'},
  {name: 'Burnley', path: 'Burnley_F.C.'},
  {name: 'Crystal Palace', path: 'Crystal_Palace_F.C.'},
  {name: 'Everton', path: 'Everton_F.C.'},
  {name: 'Newcastle United', path: 'Newcastle_United_F.C.'},
  {name: 'Southampton', path: 'Southampton_F.C.'},
  {name: 'Brighton', path: 'Brighton_%26_Hove_Albion_F.C.'},
  {name: 'West Ham United', path: 'West_Ham_United_F.C.'},
  {name: 'Watford', path: 'Watford_F.C.'},
  {name: 'Bournemouth', path: 'A.F.C._Bournemouth'},
  {name: 'Aston Villa', path: 'Aston_Villa_F.C.'},
  {name: 'Norwich City', path: 'Norwich_City_F.C.'}
]


namespace :wikipedia do
  desc "Scrape Wikipedia for a clubs and players"
  task :all => :environment do
    CLUBS.each do |club|
      club_name = club[:name]
      club_path = club[:path]
      url = "https://en.wikipedia.org/wiki/#{club_path}"
      page = Nokogiri::HTML(HTTParty.get(url))
      page.css('tbody tr.vcard.agent span.fn a').each do |player|
        club = Club.find_or_create_by(name: club_name)
        player = Player.create(name: player.text, club_id: club.id)
        p "Successfully created #{player.name} at #{club.name}"
      end
      sleep 2
    end
  end
end





