class RarebookXmlsController < ApplicationController
  def index
    @rarebook_xmls = RarebookXml.all.reverse
  end
  
  def show
  end

  def new
    @rarebook_xml = RarebookXml.new
  end

  def create
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
    @rarebook_xml = RarebookXml.find(params[:id])
    @rarebook_xml.destroy

    redirect_to(rarebook_xmls_url)
  end
end
