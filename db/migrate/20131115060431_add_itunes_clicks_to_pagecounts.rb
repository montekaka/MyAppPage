class AddItunesClicksToPagecounts < ActiveRecord::Migration
  def change
    add_column :pagecounts, :itunes_clicks, :integer
  end
end
