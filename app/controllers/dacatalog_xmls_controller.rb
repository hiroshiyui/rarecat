class DacatalogXmlsController < ApplicationController
  # GET /dacatalog_xmls
  # GET /dacatalog_xmls.xml
  def index
    @dacatalog_xmls = DacatalogXml.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dacatalog_xmls }
    end
  end

  # GET /dacatalog_xmls/1
  # GET /dacatalog_xmls/1.xml
  def show
    @dacatalog_xml = DacatalogXml.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dacatalog_xml }
    end
  end

  # GET /dacatalog_xmls/new
  # GET /dacatalog_xmls/new.xml
  def new
    @dacatalog_xml = DacatalogXml.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dacatalog_xml }
    end
  end

  # GET /dacatalog_xmls/1/edit
  def edit
    @dacatalog_xml = DacatalogXml.find(params[:id])
  end

  # POST /dacatalog_xmls
  # POST /dacatalog_xmls.xml
  def create
    @dacatalog_xml = DacatalogXml.new(params[:dacatalog_xml])

    respond_to do |format|
      if @dacatalog_xml.save
        format.html {
          @dacatalog_xml.rarebook_xmls.update_all(:status => 'Ongoing')
          redirect_to(@dacatalog_xml, :notice => 'Dacatalog xml was successfully created.') 
          }
        format.xml  { render :xml => @dacatalog_xml, :status => :created, :location => @dacatalog_xml }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dacatalog_xml.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dacatalog_xmls/1
  # PUT /dacatalog_xmls/1.xml
  def update
    @dacatalog_xml = DacatalogXml.find(params[:id])

    respond_to do |format|
      if @dacatalog_xml.update_attributes(params[:dacatalog_xml])
        format.html { redirect_to(@dacatalog_xml, :notice => 'Dacatalog xml was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dacatalog_xml.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dacatalog_xmls/1
  # DELETE /dacatalog_xmls/1.xml
  def destroy
    @dacatalog_xml = DacatalogXml.find(params[:id])
    @dacatalog_xml.destroy

    respond_to do |format|
      format.html { redirect_to(dacatalog_xmls_url) }
      format.xml  { head :ok }
    end
  end
end
