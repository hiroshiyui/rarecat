require "spec_helper"

describe DacatalogXmlsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/dacatalog_xmls" }.should route_to(:controller => "dacatalog_xmls", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/dacatalog_xmls/new" }.should route_to(:controller => "dacatalog_xmls", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/dacatalog_xmls/1" }.should route_to(:controller => "dacatalog_xmls", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/dacatalog_xmls/1/edit" }.should route_to(:controller => "dacatalog_xmls", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/dacatalog_xmls" }.should route_to(:controller => "dacatalog_xmls", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/dacatalog_xmls/1" }.should route_to(:controller => "dacatalog_xmls", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/dacatalog_xmls/1" }.should route_to(:controller => "dacatalog_xmls", :action => "destroy", :id => "1")
    end

  end
end
