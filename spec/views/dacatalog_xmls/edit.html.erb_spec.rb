require 'spec_helper'

describe "dacatalog_xmls/edit.html.erb" do
  before(:each) do
    @dacatalog_xml = assign(:dacatalog_xml, stub_model(DacatalogXml))
  end

  it "renders the edit dacatalog_xml form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => dacatalog_xmls_path(@dacatalog_xml), :method => "post" do
    end
  end
end
