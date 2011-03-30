class CreateRarebookXmls < ActiveRecord::Migration
  def self.up
    create_table :rarebook_xmls do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :rarebook_xmls
  end
end
