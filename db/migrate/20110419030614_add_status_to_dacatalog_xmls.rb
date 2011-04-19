class AddStatusToDacatalogXmls < ActiveRecord::Migration
  def self.up
    add_column :dacatalog_xmls, :status, :text
  end

  def self.down
    remove_column :dacatalog_xmls, :status
  end
end
