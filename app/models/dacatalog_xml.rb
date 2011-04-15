class DacatalogXml < ActiveRecord::Base
  has_many :rarebook_xmls
  accepts_nested_attributes_for :rarebook_xmls, :allow_destroy => true

  validates_presence_of :rarebook_xmls
end
