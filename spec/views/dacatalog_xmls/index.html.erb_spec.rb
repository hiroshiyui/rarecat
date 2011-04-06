require 'spec_helper'

describe "dacatalog_xmls/index.html.erb" do
  before(:each) do
    assign(:dacatalog_xmls, [
      stub_model(DacatalogXml),
      stub_model(DacatalogXml)
    ])
  end

  it "renders a list of dacatalog_xmls" do
    render
  end
end
