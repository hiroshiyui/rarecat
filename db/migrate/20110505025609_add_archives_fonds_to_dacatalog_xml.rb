class AddArchivesFondsToDacatalogXml < ActiveRecord::Migration
  def self.up
    add_column :dacatalog_xmls, :archives_fonds, :text
  end

  def self.down
    remove_column :dacatalog_xmls, :archives_fonds
  end
end
