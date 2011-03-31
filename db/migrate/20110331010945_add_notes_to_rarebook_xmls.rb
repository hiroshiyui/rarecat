class AddNotesToRarebookXmls < ActiveRecord::Migration
  def self.up
    add_column :rarebook_xmls, :notes, :text
  end

  def self.down
    remove_column :rarebook_xmls, :notes
  end
end
