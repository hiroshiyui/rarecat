require 'spec_helper'

describe "rarebook_xmls/index.html.erb" do
  before(:each) do
    assign(:rarebook_xmls, [
      stub_model(RarebookXml),
      stub_model(RarebookXml)
    ])
  end

  it "renders a list of rarebook_xmls" do
    render
  end
end
