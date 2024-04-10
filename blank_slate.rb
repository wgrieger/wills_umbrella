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
location_hash.class
 location_hash
user_location_search="/"+location_hash.fetch("lat").to_s + "," + location_hash.fetch("lng").to_s

#now time to get weather
 pirate_weather_URL1= "https://api.pirateweather.net/forecast/" + pirate_weather_key + user_location_search
raw_weather= HTTP.get(pirate_weather_URL1)
parsed_weather = JSON.parse(raw_weather)
parsed_weather
pp pirate_weather_URL1

#this is the output needed:
#It is currently 46.58°F.
#Next hour: Clear
#In 12 hours, there is a 11% chance of precipitation.
#You might want to take an umbrella!
