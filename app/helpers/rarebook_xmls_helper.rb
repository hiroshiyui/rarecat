module RarebookXmlsHelper
  def list_queue(rarebook_xmls)
    if rarebook_xmls.empty?
      #render :text => "Empty queue."
      render :inline => "<span>Empty queue.</span>"
    else
      render :partial => "queue"
    end
  end

  def checkable(queue)
    if queue.dacatalog_xml_id.nil?
      check_box_tag "dacatalog_xml[rarebook_xml_ids][]", queue.id, false
    else
      check_box_tag "dacatalog_xml[rarebook_xml_ids][]", queue.id, false, :disabled => true
    end
  end
end
