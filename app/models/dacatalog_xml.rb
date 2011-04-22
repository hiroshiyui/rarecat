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

  def generate # what we want.
    xslt = XML::XSLT.new

    self.items.each do |item|
      rarebook_xml = REXML::Document.new( File.open(item) )
     
      case rarebook_xml.root.name # to choose the right XSL
        when "publication" then
          xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog.xsl" )) )
        when "journalArticle" then
          xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog-journal-articles.xsl" )) )
      end
      
      xslt.xml = rarebook_xml # xslt.xml is String which doesn't fit our XML processing needs.
      xslt.parameters = {
        "date"  => Time.now.to_s,
        "xmlId" => File.basename(item, ".xml")
      }
     
      dacatalog = File.path(item).chomp(".xml").concat("-dacatalog")  # name a tmp name to indicate what the generated file is.
      xslt.save(dacatalog)
    end

    cd(storage_path)
    Zip::Archive.open("#{self.id.to_s}-dacatalog.zip", Zip::CREATE) do |ar|
      Dir.glob("**/*").each do |path|
        if File.directory?(path)
          ar.add_dir(path)
        else
          if path.end_with?("-dacatalog")
            ar.add_file(path.chomp("-dacatalog").concat(".xml"), path)  # rename the tmp names to .xml.
          end
        end
      end
    end
  end

  def clean_files
    remove_dir(storage_path, :force => true)
  end
end

class GenerationJob # a delayed_job for DacatalogXml.generate()
  attr_accessor :dacatalog_xml

  def initialize(dacatalog_xml)
    self.dacatalog_xml = dacatalog_xml
  end

  def perform
    @dacatalog_xml.update_attribute(:status, "Running")
    @dacatalog_xml.generate # NOTICE: Remember to restart delayed job server if you had modified the task statements.
  end

  def success(job)
    @dacatalog_xml.update_attribute(:status, "Success!")
  end
end
