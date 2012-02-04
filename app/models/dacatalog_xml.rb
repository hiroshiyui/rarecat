# coding: utf-8
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
      xslt.xml = rarebook_xml # xslt.xml is String which doesn't fit our XML processing needs.

      case rarebook_xml.root.name # to choose the right XSL and to pass the required parameters
        when "publication" then
          case rarebook_xml.root.elements["type[1]"].text
            when "圖書" then
              xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog.xsl" )) )
              xslt.parameters = {
                "date"          => Time.now.to_s,
                "xmlId"         => File.basename(item, ".xml")
              }
            when "期刊" then
              xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog.xsl" )) )

              if Journal.find_by_unique_id( rarebook_xml.root.elements["uniqueId[1]"].text ).nil? # means we can't find that journal
                logger.debug "#{File.basename(item)} - Error: No such journal in mapping table."
                next  # skip this item
              else
                xslt.parameters = {
                  "date"          => Time.now.to_s,
                  "xmlId"         => File.basename(item, ".xml"),
                  "firstIssue"    => Journal.find_by_unique_id( rarebook_xml.root.elements["uniqueId[1]"].text ).first_issue
                }
              end
          end
        when "journalArticle" then  # 期刊篇目
          xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog-journal-articles.xsl" )) )

          if Journal.find_by_unique_id( rarebook_xml.root.elements["journalId[1]"].text ).nil?
            logger.debug "#{File.basename(item)} - Error: No such journal in mapping table."
            next
          else
            xslt.parameters = {
              "date"          => Time.now.to_s,
              "xmlId"         => File.basename(item, ".xml"),
              "collectionSet" => Journal.find_by_unique_id( rarebook_xml.root.elements["journalId[1]"].text ).collection_set,
              "repository"    => Journal.find_by_unique_id( rarebook_xml.root.elements["journalId[1]"].text ).repository,
              "journalTitle"  => Journal.find_by_unique_id( rarebook_xml.root.elements["journalId[1]"].text ).title
            }
          end
        when "archive" then # TAIS
          xslt.xsl = REXML::Document.new( File.open( Rails.root.join( "public", "dacatalog-tais.xsl" )) )
          xslt.parameters = {
            "date"            => Time.now.to_s,
            "xmlId"           => File.basename(item, ".xml"),
            "archivesType"    => self.archives_type,
            "archivesFonds"   => self.archives_fonds,
            "archivesSeries"  => self.archives_series
          }
      end

      dacatalog = File.path(item).chomp(".xml").concat("-dacatalog")  # name a tmp name to indicate what the generated file is.
      xslt.save(dacatalog)
    end

    cd(storage_path)

    Dir.glob("**/*").each do |path|
      Zip::Archive.open("#{self.id.to_s}-dacatalog.zip", Zip::CREATE) do |archive|
        if File.directory?(path)
          archive.add_dir(path)
        else
          if path.end_with?("-dacatalog")
            archive.add_file(path.chomp("-dacatalog").concat(".xml"), path) # rename the tmp names to .xml.
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
    @dacatalog_xml.rarebook_xmls.update_all(:status => "Job's done.")
    #ActionController::Base.expire_page :controller => "rarebook_xmls", :action => "index"
  end
  
  def error(job, exception)
    @dacatalog_xml.update_attribute(:status, "Error...")
    @dacatalog_xml.rarebook_xmls.update_all(:status => "Error occurred.")
    #ActionController::Base.expire_page :controller => "rarebook_xmls", :action => "index"
  end

  def failure
    @dacatalog_xml.update_attribute(:status, "Failed...")
    @dacatalog_xml.rarebook_xmls.update_all(:status => "Job's failed.")
    #ActionController::Base.expire_page :controller => "rarebook_xmls", :action => "index"
  end
end
