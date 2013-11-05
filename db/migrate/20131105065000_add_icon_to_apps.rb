class AddIconToApps < ActiveRecord::Migration
  def change
    add_column :apps, :icon, :string
  end
end
