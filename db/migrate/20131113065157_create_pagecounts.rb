class CreatePagecounts < ActiveRecord::Migration
  def change
    create_table :pagecounts do |t|
      t.integer :pageview

      t.timestamps
    end
  end
end
