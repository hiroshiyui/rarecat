require 'zipruby'
require 'rexml/document'
require 'xml/xslt'

class DacatalogXml < ActiveRecord::Base
  include FileUtils # mixins mkdir_p, cd, remove_dir...
  has_many :rarebook_xmls
  accepts_nested_attributes_for :rarebook_xmls, :allow_destroy => true

  validates_presence_of :rarebook_xmls

  def storage_path
    Rails.root.join( "public", "system", "dacatalog", self.id.to_s )
  end

  def prepare_files # make working directories, extract zip files.
    mkdir_p(storage_path)
    
    self.rarebook_xmls.each do |rarebook_xml|
      mkdir_p(storage_path.join(rarebook_xml.id.to_s))
      cd(storage_path.join(rarebook_xml.id.to_s))
      
      Zip::Archive.open(rarebook_xml.zip.path) do |archive|
        archive.each do |zip_content|
          if zip_content.directory?
            mkdir_p(zip_content.name)
          else
            dirname = File.dirname(zip_content.name)
            mkdir_p(dirname) unless File.exist?(dirname)

            open(zip_content.name, 'wb') do |file|
              file << zip_content.read
            end
          end
        end
      end
    end
  end
  
  def items # what inside working directories.
    Dir.glob(File.join( storage_path, "**", "*.xml" ))
  end

  def generate
    xslt = XML::XSLT.new

    self.items.each do |item|
      xslt.xml = REXML::Document.new( File.open(item) )
      xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog.xsl" )) )
      xslt.parameters = {"date" => Time.now.to_s}
      #out = xslt.serve
      #print out
    end
  end
  
  def clean_files
    remove_dir(storage_path, :force => true)
  end
end
