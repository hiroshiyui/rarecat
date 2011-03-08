class CreateRarebooks < ActiveRecord::Migration
  def self.up
    create_table :rarebooks do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :rarebooks
  end
end
