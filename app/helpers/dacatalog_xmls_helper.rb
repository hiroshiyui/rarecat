module DacatalogXmlsHelper
  def downloadable?(dacatalog_xml)
    if dacatalog_xml.status == "Success!"
      link_to "Download", dacatalog_xml_path(dacatalog_xml, :format => :zip)
    end
  end
end
