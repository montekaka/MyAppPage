class AddTrackViewUrlToApps < ActiveRecord::Migration
  def change
    add_column :apps, :trackViewUrl, :string
  end
end
