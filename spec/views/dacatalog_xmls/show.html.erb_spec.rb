require 'spec_helper'

describe "dacatalog_xmls/show.html.erb" do
  before(:each) do
    @dacatalog_xml = assign(:dacatalog_xml, stub_model(DacatalogXml))
  end

  it "renders attributes in <p>" do
    render
  end
end
