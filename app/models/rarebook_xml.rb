class RarebookXml < ActiveRecord::Base
  has_attached_file :zip
  validates_attachment_content_type :zip, :content_type => "application/zip"
  validates_attachment_presence :zip
end
