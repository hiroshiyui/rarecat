class RarebookXml < ActiveRecord::Base
  belongs_to :dacatalog_xml
  has_attached_file :zip
  validates_attachment_content_type :zip, :content_type => ['application/zip', 'application/x-zip-compressed']
  validates_attachment_presence :zip
end
