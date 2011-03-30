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
    #@rarebookxml = RarebookXml.create( params[:rarebookxml] )
    @rarebookxml = RarebookXml.new( params[:rarebookxml] )

    respond_to do |format|
      if @rarebookxml.save
        format.html { redirect_to(@rarebookxml,
                      :notice => 'Queue was successfully created.') }
        format.xml  { render :xml => @rarebookxml,
                      :status => :created, :location => @rarebookxml }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rarebookxml.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
