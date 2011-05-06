class AddArchivesTypeToDacatalogXml < ActiveRecord::Migration
  def self.up
    add_column :dacatalog_xmls, :archives_type, :text
  end

  def self.down
    remove_column :dacatalog_xmls, :archives_type
  end
end
