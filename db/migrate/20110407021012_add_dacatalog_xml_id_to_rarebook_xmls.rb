class AddDacatalogXmlIdToRarebookXmls < ActiveRecord::Migration
  def self.up
    add_column :rarebook_xmls, :dacatalog_xml_id, :integer
  end

  def self.down
    remove_column :rarebook_xmls, :dacatalog_xml_id
  end
end
