class CreateDacatalogXmls < ActiveRecord::Migration
  def self.up
    create_table :dacatalog_xmls do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :dacatalog_xmls
  end
end
