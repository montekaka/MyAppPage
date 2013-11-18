# encoding: UTF-8
desc "Mixpanel Data Export by Apps"
task :mixpanel_data_export => :environment do	
	require 'mixpanel_data_export.rb'
	apps = App.all
	appIDs = []
	apps.each do |a|
		appIDs.push(a.id.to_s)
	end
	puts appIDs.length
	stats = get_mixpanel_data(appIDs)

	stats.each do |f,v|
		puts "AppID: " + f + " "+ v["date"] +" Page View: "+v["pageView"].to_s + " iTunes Clicks " + v["itunesClick"].to_s
		app = App.find_by_id(f.to_i)
		puts app.trackName
		app.pagecounts.create(:mixpanel_data=>v['date'], :pageview=>v["pageView"], :itunes_clicks=>v['itunesClick'])
	end	
end