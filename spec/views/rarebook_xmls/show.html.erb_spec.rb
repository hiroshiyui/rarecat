require 'spec_helper'

describe "rarebook_xmls/show.html.erb" do
  before(:each) do
    @rarebook_xml = assign(:rarebook_xml, stub_model(RarebookXml))
  end

  it "renders attributes in <p>" do
    render
  end
end
