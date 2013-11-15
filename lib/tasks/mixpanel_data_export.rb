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

fuck = get_live_page_count(["13","14","15","16"], 'App LandingPage Viewed')
puts fuck
fuck.each do |f,v|
	puts v["clicks"]
end
