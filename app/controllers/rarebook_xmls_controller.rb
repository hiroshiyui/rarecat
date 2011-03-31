class RarebookXmlsController < ApplicationController
  def index
    @rarebookxmls = RarebookXml.all.reverse
  end
  
  def show
  end

  def new
    @rarebookxml = RarebookXml.new
  end

  def create
    @rarebookxml = RarebookXml.new(params[:rarebook_xml])

    if @rarebookxml.save
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
    @rarebookxml = RarebookXml.find(params[:id])
    @rarebookxml.destroy

    redirect_to(rarebook_xmls_url)
  end
end
