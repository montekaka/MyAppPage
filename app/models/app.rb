class App < ActiveRecord::Base
	belongs_to :user
	has_many :pagecounts

	def get_live_page_count
		# get page_count from mixpanel
		config = {
			api_key: 'dc026b4b9413dcce8e3ac0374ef906e5', 
			api_secret: 'd144302ca4443c49420569d07d1c9e15'
		}

		client = Mixpanel::Client.new(config)

		data = client.request('events/properties', {
		  event:     'App LandingPage Viewed',  
		  name:      'Landing Page ID',
		  values:     [self.id.to_s],
		  type:      'unique',
		  unit:      'day',
		  interval:   1,
		})

		puts "************ Mixpanel loaded!!!! ****************"
		puts data.inspect
		result = 0
		if data["legend_size"] == 0
			return 0
		elsif data["data"]["series"].length == 1						
			data["data"]["values"].each do |key, value|
				value.each do |k, v|
					return v
				end
			end
		else
			data["data"]["values"].each do |key, value|				
				value.each do |k, v|
					result = result + v
				end
			end
			return result
		end
	end

	def get_itunes_button_click_count
		# get page_count from mixpanel
		config = {
			api_key: 'dc026b4b9413dcce8e3ac0374ef906e5', 
			api_secret: 'd144302ca4443c49420569d07d1c9e15'
		}

		client = Mixpanel::Client.new(config)
		
		data = client.request('events/properties', {
		  event:     'Click Apps iTunes',  
		  name:      'Landing Page ID',
		  values:     [self.id.to_s],
		  type:      'unique',
		  unit:      'day',
		  interval:   1,
		})
		
		puts "************ Mixpanel loaded button Click!!!! ****************"
		result = 0
		if data["legend_size"] == 0
			return 0
		elsif data["data"]["series"].length == 1						
			data["data"]["values"].each do |key, value|
				value.each do |k, v|
					return v
				end
			end
		else
			data["data"]["values"].each do |key, value|				
				value.each do |k, v|
					result = result + v
				end
			end
			return result
		end
	end
end
