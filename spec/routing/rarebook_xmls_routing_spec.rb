require "spec_helper"

describe RarebookXmlsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/rarebook_xmls" }.should route_to(:controller => "rarebook_xmls", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/rarebook_xmls/new" }.should route_to(:controller => "rarebook_xmls", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/rarebook_xmls/1" }.should route_to(:controller => "rarebook_xmls", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/rarebook_xmls/1/edit" }.should route_to(:controller => "rarebook_xmls", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/rarebook_xmls" }.should route_to(:controller => "rarebook_xmls", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/rarebook_xmls/1" }.should route_to(:controller => "rarebook_xmls", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/rarebook_xmls/1" }.should route_to(:controller => "rarebook_xmls", :action => "destroy", :id => "1")
    end

  end
end
