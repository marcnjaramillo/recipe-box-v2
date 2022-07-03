module ApplicationHelper
  def is_active(path)       
    request.path == path ? 'active' : ''     
  end

  def nested_active(controller)       
    params[:controller] == controller ? 'active' : ''     
  end
end
