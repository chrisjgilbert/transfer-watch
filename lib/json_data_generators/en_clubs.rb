require 'json'

LEAGUE_CLUBS = '<li><a href="/wiki/Barnsley_F.C." title="Barnsley F.C.">Barnsley</a></li>
<li><a href="/wiki/Birmingham_City_F.C." title="Birmingham City F.C.">Birmingham City</a></li>
<li><a href="/wiki/Brentford_F.C." title="Brentford F.C.">Brentford</a></li>
<li><a href="/wiki/Bristol_City_F.C." title="Bristol City F.C.">Bristol City</a></li>
<li><a href="/wiki/Blackburn_Rovers_F.C." title="Blackburn Rovers F.C.">Blackburn Rovers</a></li>
<li><a href="/wiki/Cardiff_City_F.C." title="Cardiff City F.C.">Cardiff City</a></li>
<li><a href="/wiki/Charlton_Athletic_F.C." title="Charlton Athletic F.C.">Charlton Athletic</a></li>
<li><a href="/wiki/Derby_County_F.C." title="Derby County F.C.">Derby County</a></li>
<li><a href="/wiki/Fulham_F.C." title="Fulham F.C.">Fulham</a></li>
<li><a href="/wiki/Huddersfield_Town_A.F.C." title="Huddersfield Town A.F.C.">Huddersfield Town</a></li>
<li><a href="/wiki/Hull_City_A.F.C." title="Hull City A.F.C.">Hull City</a></li>
<li><a href="/wiki/Leeds_United_F.C." title="Leeds United F.C.">Leeds United</a></li>
<li><a href="/wiki/Luton_Town_F.C." title="Luton Town F.C.">Luton Town</a></li>
<li><a href="/wiki/Middlesbrough_F.C." title="Middlesbrough F.C.">Middlesbrough</a></li>
<li><a href="/wiki/Millwall_F.C." title="Millwall F.C.">Millwall</a></li>
<li><a href="/wiki/Nottingham_Forest_F.C." title="Nottingham Forest F.C.">Nottingham Forest</a></li>
<li><a href="/wiki/Preston_North_End_F.C." title="Preston North End F.C.">Preston North End</a></li>
<li><a href="/wiki/Queens_Park_Rangers_F.C." title="Queens Park Rangers F.C.">Queens Park Rangers</a></li>
<li><a href="/wiki/Reading_F.C." title="Reading F.C.">Reading</a></li>
<li><a href="/wiki/Sheffield_Wednesday_F.C." title="Sheffield Wednesday F.C.">Sheffield Wednesday</a></li>
<li><a href="/wiki/Stoke_City_F.C." title="Stoke City F.C.">Stoke City</a></li>
<li><a href="/wiki/Swansea_City_Association_Football_Club" class="mw-redirect" title="Swansea City Association Football Club">Swansea City</a></li>
<li><a href="/wiki/West_Bromich_Albion" class="mw-redirect" title="West Bromich Albion">West Brom</a></li>
<li><a href="/wiki/Wigan_Athletic_F.C." title="Wigan Athletic F.C.">Wigan Athletic</a></li>
<li><a href="/wiki/Accrington_Stanley_F.C." title="Accrington Stanley F.C.">Accrington Stanley</a></li>
<li><a href="/wiki/AFC_Wimbledon" title="AFC Wimbledon">AFC Wimbledon</a></li>
<li><a href="/wiki/Blackpool_F.C." title="Blackpool F.C.">Blackpool</a></li>
<li><a href="/wiki/Bolton_Wanderers_F.C." title="Bolton Wanderers F.C.">Bolton Wanderers</a></li>
<li><a href="/wiki/Bristol_Rovers_F.C." title="Bristol Rovers F.C.">Bristol Rovers</a></li>
<li><a href="/wiki/Burton_Albion_F.C." title="Burton Albion F.C.">Burton Albion</a></li>
<li><a href="/wiki/Coventry_City_F.C." title="Coventry City F.C.">Coventry City</a></li>
<li><a href="/wiki/Doncaster_Rovers_F.C." title="Doncaster Rovers F.C.">Doncaster Rovers</a></li>
<li><a href="/wiki/Fleetwood_Town_F.C." title="Fleetwood Town F.C.">Fleetwood Town</a></li>
<li><a href="/wiki/Gillingham_F.C." title="Gillingham F.C.">Gillingham</a></li>
<li><a href="/wiki/Ipswich_Town_F.C." title="Ipswich Town F.C.">Ipswich Town</a></li>
<li><a href="/wiki/Lincoln_City_F.C." title="Lincoln City F.C.">Lincoln City</a></li>
<li><a href="/wiki/Milton_Keynes_Dons_F.C." title="Milton Keynes Dons F.C.">Milton Keynes Dons</a></li>
<li><a href="/wiki/Oxford_United_F.C." title="Oxford United F.C.">Oxford United</a></li>
<li><a href="/wiki/Peterborough_United_F.C." title="Peterborough United F.C.">Peterborough United</a></li>
<li><a href="/wiki/Portsmouth_F.C." title="Portsmouth F.C.">Portsmouth</a></li>
<li><a href="/wiki/Rochdale_A.F.C." title="Rochdale A.F.C.">Rochdale</a></li>
<li><a href="/wiki/Rotherham_United_F.C." title="Rotherham United F.C.">Rotherham United</a></li>
<li><a href="/wiki/Shrewsbury_Town_F.C." title="Shrewsbury Town F.C.">Shrewsbury Town</a></li>
<li><a href="/wiki/Southend_United_F.C." title="Southend United F.C.">Southend United</a></li>
<li><a href="/wiki/Sunderland_A.F.C." title="Sunderland A.F.C.">Sunderland</a></li>
<li><a href="/wiki/Tranmere_Rovers_F.C." title="Tranmere Rovers F.C.">Tranmere Rovers</a></li>
<li><a href="/wiki/Wycombe_Wanderers_F.C." title="Wycombe Wanderers F.C.">Wycombe Wanderers</a></li>
<li><a href="/wiki/Bradford_City_A.F.C." title="Bradford City A.F.C.">Bradford City</a></li>
<li><a href="/wiki/Cambridge_United_F.C." title="Cambridge United F.C.">Cambridge United</a></li>
<li><a href="/wiki/Carlisle_United_F.C." title="Carlisle United F.C.">Carlisle United</a></li>
<li><a href="/wiki/Cheltenham_Town_F.C." title="Cheltenham Town F.C.">Cheltenham Town</a></li>
<li><a href="/wiki/Colchester_United_F.C." title="Colchester United F.C.">Colchester United</a></li>
<li><a href="/wiki/Crawley_Town_F.C." title="Crawley Town F.C.">Crawley Town</a></li>
<li><a href="/wiki/Crewe_Alexandra_F.C." title="Crewe Alexandra F.C.">Crewe Alexandra</a></li>
<li><a href="/wiki/Exeter_City_F.C." title="Exeter City F.C.">Exeter City</a></li>
<li><a href="/wiki/Forest_Green_Rovers_F.C." title="Forest Green Rovers F.C.">Forest Green Rovers</a></li>
<li><a href="/wiki/Grimsby_Town_F.C." title="Grimsby Town F.C.">Grimsby Town</a></li>
<li><a href="/wiki/Leyton_Orient_F.C." title="Leyton Orient F.C.">Leyton Orient</a></li>
<li><a href="/wiki/Macclesfield_Town_F.C." title="Macclesfield Town F.C.">Macclesfield Town</a></li>
<li><a href="/wiki/Mansfield_Town_F.C." title="Mansfield Town F.C.">Mansfield Town</a></li>
<li><a href="/wiki/Morecambe_F.C." title="Morecambe F.C.">Morecambe</a></li>
<li><a href="/wiki/Newport_County_A.F.C." title="Newport County A.F.C.">Newport County</a></li>
<li><a href="/wiki/Northampton_Town_F.C." title="Northampton Town F.C.">Northampton Town</a></li>
<li><a href="/wiki/Oldham_Athletic_F.C." class="mw-redirect" title="Oldham Athletic F.C.">Oldham Athletic</a></li>
<li><a href="/wiki/Port_Vale_F.C." title="Port Vale F.C.">Port Vale</a></li>
<li><a href="/wiki/Plymouth_Argyle_F.C." title="Plymouth Argyle F.C.">Plymouth Argyle</a></li>
<li><a href="/wiki/Salford_City_F.C." title="Salford City F.C.">Salford City</a></li>
<li><a href="/wiki/Scunthorpe_United_F.C." title="Scunthorpe United F.C.">Scunthorpe United</a></li>
<li><a href="/wiki/Stevenage_F.C." title="Stevenage F.C.">Stevenage</a></li>
<li><a href="/wiki/Swindon_Town_F.C." title="Swindon Town F.C.">Swindon Town</a></li>
<li><a href="/wiki/Walsall_F.C" class="mw-redirect" title="Walsall F.C">Walsall</a></li>'

EPL_CLUBS = [
  {name: 'Chelsea', path: 'Chelsea_F.C.'},
  {name: 'Arsenal', path: 'Arsenal_F.C.'},
  {name: 'Manchester City', path: 'Manchester_City_F.C.'},
  {name: 'Manchester United', path: 'Manchester_United_F.C.'},
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

hash = {}
LEAGUE_CLUBS.split('</li>').each do |line|
  link = line.scan(/href\s*=\s*"([^"]*)"/).first&.join
  name = line.scan(/<a[^>]*>([^<]+)<\/a>/).first&.join
  hash["#{name}"] = link
end

EPL_CLUBS.each do |club|
  hash["#{club[:name]}"] = "/wiki/#{club[:path]}"
end

sorted_hash = hash.sort.to_h

File.open("json_data/en_clubs.json","w") do |f|
  f.write(sorted_hash.to_json)
end