class DacatalogXml < ActiveRecord::Base
  has_many :rarebook_xmls
  accepts_nested_attributes_for :rarebook_xmls, :allow_destroy => true
end
