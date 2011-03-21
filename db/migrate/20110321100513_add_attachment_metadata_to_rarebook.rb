class AddAttachmentMetadataToRarebook < ActiveRecord::Migration
  def self.up
    add_column :rarebooks, :metadata_file_name, :string
    add_column :rarebooks, :metadata_content_type, :string
    add_column :rarebooks, :metadata_file_size, :integer
    add_column :rarebooks, :metadata_updated_at, :datetime
  end

  def self.down
    remove_column :rarebooks, :metadata_file_name
    remove_column :rarebooks, :metadata_content_type
    remove_column :rarebooks, :metadata_file_size
    remove_column :rarebooks, :metadata_updated_at
  end
end
