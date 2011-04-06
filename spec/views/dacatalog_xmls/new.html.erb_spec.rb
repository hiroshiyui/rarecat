require 'spec_helper'

describe "dacatalog_xmls/new.html.erb" do
  before(:each) do
    assign(:dacatalog_xml, stub_model(DacatalogXml).as_new_record)
  end

  it "renders new dacatalog_xml form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => dacatalog_xmls_path, :method => "post" do
    end
  end
end
