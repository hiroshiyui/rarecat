require 'spec_helper'

describe "rarebook_xmls/edit.html.erb" do
  before(:each) do
    @rarebook_xml = assign(:rarebook_xml, stub_model(RarebookXml))
  end

  it "renders the edit rarebook_xml form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rarebook_xmls_path(@rarebook_xml), :method => "post" do
    end
  end
end
