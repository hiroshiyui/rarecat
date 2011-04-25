class AddFirstIssueToJournals < ActiveRecord::Migration
  def self.up
    add_column :journals, :first_issue, :text
  end

  def self.down
    remove_column :journals, :first_issue
  end
end
