class AddMixpanelDateToPagecounts < ActiveRecord::Migration
  def change
    add_column :pagecounts, :mixpanel_data, :date
  end
end
