require "http"
require "json"

#need user location
#pp "Where are you located?"
#user_location= gets
#user_location = user_location.strip
#pp user_location

#user location for testing
user_location = "Minneapolis"

#keys
gmaps_key = ENV["GMAPS_KEY"]
pirate_weather_key = ENV["PIRATE_WEATHER_KEY"]

gmaps_host= "https://maps.googleapis.com"
gmaps_resource="/maps/api/geocode/json"

gmaps_unique= "?address=" + user_location
gmaps_unique_stripped= gmaps_unique.strip

gmaps_key = "&key=" + ENV["GMAPS_KEY"]
gmaps_key_stripped=gmaps_key.strip


gmaps_url= gmaps_host + gmaps_resource + gmaps_unique_stripped + gmaps_key_stripped 

raw_gmaps= HTTP.get(gmaps_url)

parsed_gmaps= JSON.parse(raw_gmaps)
parsed_gmaps

results_array = parsed_gmaps.fetch("results")
"results_array class" + results_array.class.to_s
results_array
results_array.count
results_hash= results_array[0]
results_hash

address_hash= results_hash.fetch("geometry")
address_hash
#geometry_hash=address_hash.fetch("geometry")
location_hash=address_hash.fetch("location")
pp location_hash.class
pp location_hash
