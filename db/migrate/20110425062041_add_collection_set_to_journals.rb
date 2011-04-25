class AddCollectionSetToJournals < ActiveRecord::Migration
  def self.up
    add_column :journals, :collection_set, :text
  end

  def self.down
    remove_column :journals, :collection_set
  end
end
