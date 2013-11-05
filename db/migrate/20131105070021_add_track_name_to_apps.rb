class AddTrackNameToApps < ActiveRecord::Migration
  def change
    add_column :apps, :trackName, :string
  end
end
