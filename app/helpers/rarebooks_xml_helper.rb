module RarebooksXmlHelper
  def list_queue(rarebooks)
    if rarebooks.empty?
      #render :text => "Empty queue."
      render :inline => "<span>Empty queue.</span>"
    else
      render :layout => "queue"
    end
  end
end
