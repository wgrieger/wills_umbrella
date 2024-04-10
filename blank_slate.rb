require "http"
require "json"
require "time"


#need user location
puts "Where are you located?"
user_location= gets
user_location = user_location.strip
#pp user_location

#user location for testing
#user_location = "Minneapolis"

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

puts "Checking the weather at " + user_location.to_s + "...."
puts "Your coordinates are " +location_hash.fetch("lat").to_s + ", " + location_hash.fetch("lng").to_s + "."

#now time to get weather
 pirate_weather_URL1= "https://api.pirateweather.net/forecast/" + pirate_weather_key + user_location_search
raw_weather= HTTP.get(pirate_weather_URL1)
parsed_weather = JSON.parse(raw_weather)
pirate_weather_URL1

parsed_weather.fetch("currently")
current_weather_hash=parsed_weather.fetch("currently")
current_temp=current_weather_hash.fetch("temperature")

puts "It is currently " + current_temp.to_s + " \u00B0F."
 time= Time.now.getlocal('-05:00')
 time.zone
 display_time_chi= time.strftime("%I:%M")
 time_utc= Time.now
#puts display_time_utc= time_utc
#puts display_time_chi


#next_hour_output
 hourly_weather_fetch= parsed_weather.fetch("hourly")
  into_data_hourly_weather=hourly_weather_fetch.fetch("data")
   into_data_hourly_weather.class
   #change 0 to whichever future forecast to access
   #0=this hour
  data_hash_access= into_data_hourly_weather.fetch(1)
   #time_of_forecast_being_accessed=data_hash_access.fetch("time")
   #timestamp = time_of_forecast_being_accessed
   #time = Time.at(timestamp)
   #puts time
#outputs precip %
puts "Next hour: " + weather_summary_future= data_hash_access.fetch("summary")

#need to if it 
#puts "Chance of precipitation for the next five hours: " +  weather_summary_future= data_hash_access.fetch("precipProbability").to_s
puts " "
next_hour= 0
precip_forecast= 12.times do  next_hour= next_hour + 1
                 data_hash_access= into_data_hourly_weather.fetch(next_hour)
                 puts "The chance of precipitation in " + next_hour.to_s + " hours is " + weather_summary_future= data_hash_access.fetch("precipProbability").to_s + "."
                end

puts " "
if precip_forecast > 0.0
  then puts "You should bring an umbrella!"
end

#this is the output needed:
#It is currently 46.58°F.
#Next hour: Clear
#In 12 hours, there is a 11% chance of precipitation.
#You might want to take an umbrella!
