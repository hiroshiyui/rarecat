module RarebookXmlsHelper
  def list_queue(rarebookxmls)
    if rarebookxmls.empty?
      #render :text => "Empty queue."
      render :inline => "<span>Empty queue.</span>"
    else
      render :partial => "queue"
    end
  end
end
