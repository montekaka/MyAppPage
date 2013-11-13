class AddAppIdToPagecounts < ActiveRecord::Migration
  def change
    add_column :pagecounts, :app_id, :integer
    add_index :pagecounts, :app_id
  end
end
