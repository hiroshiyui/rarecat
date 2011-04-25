class AddTitleToJournals < ActiveRecord::Migration
  def self.up
    add_column :journals, :title, :text
  end

  def self.down
    remove_column :journals, :title
  end
end
