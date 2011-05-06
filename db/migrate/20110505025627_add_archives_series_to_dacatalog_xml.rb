class AddArchivesSeriesToDacatalogXml < ActiveRecord::Migration
  def self.up
    add_column :dacatalog_xmls, :archives_series, :text
  end

  def self.down
    remove_column :dacatalog_xmls, :archives_series
  end
end
