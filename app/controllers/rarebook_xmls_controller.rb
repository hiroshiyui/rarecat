class RarebookXmlsController < ApplicationController
  def index
    @rarebookxmls = RarebookXml.all
  end
  
  def show
  end

  def new
    @rarebookxml = RarebookXml.new
  end

  def create
    @rarebookxml = RarebookXml.create( params[:rarebook_xml] )
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
