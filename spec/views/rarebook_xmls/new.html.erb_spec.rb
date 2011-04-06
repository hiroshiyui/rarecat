require 'spec_helper'

describe "rarebook_xmls/new.html.erb" do
  before(:each) do
    assign(:rarebook_xml, stub_model(RarebookXml).as_new_record)
  end

  it "renders new rarebook_xml form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rarebook_xmls_path, :method => "post" do
    end
  end
end
