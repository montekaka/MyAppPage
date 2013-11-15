require 'rubygems'
require 'date'
require 'mixpanel_client'

#appsIDs is an array
def get_live_page_count(appsIDs, eventName)

	config = {
		api_key: 'dc026b4b9413dcce8e3ac0374ef906e5', 
		api_secret: 'd144302ca4443c49420569d07d1c9e15'
	}

	client = Mixpanel::Client.new(config)

	data = client.request('events/properties', {
	  event:     eventName,
	  name:      'Landing Page ID',
	  values:     appsIDs,
	  type:      'unique',
	  unit:      'day',
	  interval:   1,
	})

	current_date = data["data"]["series"][0]
	values = data["data"]["values"]
	
	results = Hash.new
	appsIDs.each do |id|
		if values[id].nil?
			value = 0
		else
			value = values[id][current_date]
		end
		results[id] = {"date"=>current_date,"clicks"=>value}
	end
	
	return results
end

#appsIDs is an array
def get_mixpanel_data(appsIDs)	

	config = {
		api_key: 'dc026b4b9413dcce8e3ac0374ef906e5', 
		api_secret: 'd144302ca4443c49420569d07d1c9e15'
	}

	client = Mixpanel::Client.new(config)

	pageViewdata = client.request('events/properties', {
	  event:     'App LandingPage Viewed',
	  name:      'Landing Page ID',
	  values:     appsIDs,
	  type:      'unique',
	  unit:      'day',
	  interval:   1,
	})

	itunesClicks = client.request('events/properties', {
	  event:     'Click Apps iTunes',
	  name:      'Landing Page ID',
	  values:     appsIDs,
	  type:      'unique',
	  unit:      'day',
	  interval:   1,
	})


	current_date = pageViewdata["data"]["series"][0]
	values = pageViewdata["data"]["values"]
	iTunesClick_values = itunesClicks["data"]["values"]
	
	results = Hash.new
	appsIDs.each do |id|
		if values[id].nil?
			value = 0
		else
			value = values[id][current_date]
		end
		if iTunesClick_values[id].nil?
			iTunes_Click = 0
		else
			iTunes_Click = iTunesClick_values[id][current_date]
		end

		results[id] = {"date"=>current_date,"pageView"=>value, "itunesClick"=>iTunes_Click}
	end
	
	return results
end


#fuck = get_live_page_count(["13","14","15","16"], 'App LandingPage Viewed')

# fuck = get_mixpanel_data(["13","14","15","16"])
# puts fuck
# fuck.each do |f,v|
# 	puts "Page View: "+v["pageView"].to_s + " iTunes Clicks " + v["itunesClick"].to_s
# end
