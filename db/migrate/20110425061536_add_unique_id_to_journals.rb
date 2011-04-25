class AddUniqueIdToJournals < ActiveRecord::Migration
  def self.up
    add_column :journals, :unique_id, :text
  end

  def self.down
    remove_column :journals, :unique_id
  end
end
