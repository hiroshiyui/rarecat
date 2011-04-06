module RarebookXmlsHelper
  def list_queue(rarebook_xmls)
    if rarebook_xmls.empty?
      #render :text => "Empty queue."
      render :inline => "<span>Empty queue.</span>"
    else
      render :partial => "queue"
    end
  end
end
