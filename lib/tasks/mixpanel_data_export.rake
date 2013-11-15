# encoding: UTF-8
desc "Mixpanel Data Export by Apps"
task :mixpanel_data_export => :environment do
	apps = App.all
	apps.each do |a|
		puts a.id
	end
end