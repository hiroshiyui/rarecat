require 'spec_helper'

describe "RarebookXmls" do
  describe "GET /rarebook_xmls" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get rarebook_xmls_path
      response.status.should be(200)
    end
  end
end
