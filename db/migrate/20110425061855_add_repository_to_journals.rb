class AddRepositoryToJournals < ActiveRecord::Migration
  def self.up
    add_column :journals, :repository, :text
  end

  def self.down
    remove_column :journals, :repository
  end
end
