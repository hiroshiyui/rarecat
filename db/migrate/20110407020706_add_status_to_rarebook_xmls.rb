class AddStatusToRarebookXmls < ActiveRecord::Migration
  def self.up
    add_column :rarebook_xmls, :status, :text
  end

  def self.down
    remove_column :rarebook_xmls, :status
  end
end
