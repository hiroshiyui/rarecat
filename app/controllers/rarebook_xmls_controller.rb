class RarebookXmlsController < ApplicationController
  caches_page :index

  def index
    @rarebook_xmls = RarebookXml.all.reverse
    @dacatalog_xml = DacatalogXml.new
  end
  
  def show
    @rarebook_xml = RarebookXml.find(params[:id])
  end

  def new
    @rarebook_xml = RarebookXml.new
  end

  def create
    expire_page :action => :index

    @rarebook_xml = RarebookXml.new(params[:rarebook_xml])

    if @rarebook_xml.save
      redirect_to(rarebook_xmls_url, :notice => 'File was successfully uploaded.')
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
    expire_page :action => :index

    @rarebook_xml = RarebookXml.find(params[:id])
    @rarebook_xml.destroy

    redirect_to(rarebook_xmls_url)
  end
end
