class App < ActiveRecord::Base
	belongs_to :user
	has_many :pagecounts

	def get_page_count
		stats = pagecounts.sum(:pageview)
		return stats
	end

	def get_itunes_button_click_count
		stats = pagecounts.sum(:itunes_clicks)
		return stats
	end

	def self.get_mixpanel_date(appsIDs)
		
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
end
