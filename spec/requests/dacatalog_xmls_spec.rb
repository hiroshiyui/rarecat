require 'spec_helper'

describe "DacatalogXmls" do
  describe "GET /dacatalog_xmls" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dacatalog_xmls_path
      response.status.should be(200)
    end
  end
end
