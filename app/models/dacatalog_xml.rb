require 'zipruby'
require 'xml/xslt'

class DacatalogXml < ActiveRecord::Base
  has_many :rarebook_xmls
  accepts_nested_attributes_for :rarebook_xmls, :allow_destroy => true

  validates_presence_of :rarebook_xmls

  def storage_path
    Rails.root.join( "public", "system", "dacatalog", self.id.to_s )
  end

  def mkfiles
    FileUtils.mkdir_p(storage_path)
    
    self.rarebook_xmls.each do |rarebook_xml|
      FileUtils.mkdir_p(storage_path.join(rarebook_xml.id.to_s))
      FileUtils.cd(storage_path.join(rarebook_xml.id.to_s))
      
      Zip::Archive.open(rarebook_xml.zip.path) do |archive|
        archive.each do |zip_content|
          if zip_content.directory?
            FileUtils.mkdir_p(zip_content.name)
          else
            dirname = File.dirname(zip_content.name)
            FileUtils.mkdir_p(dirname) unless File.exist?(dirname)

            open(zip_content.name, 'wb') do |file|
              file << zip_content.read
            end
          end
        end
      end
    end
  end

  def rmfiles
    FileUtils.remove_dir(storage_path, :force => true)
  end

  def convert
  end
end

class File
  def is_xml?(file_name)
  end
end
