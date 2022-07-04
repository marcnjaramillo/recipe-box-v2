module ApplicationHelper
  def is_active(path)       
    request.path == path ? 'bg-cyan-700 text-white' : 'text-gray-300 hover:bg-cyan-600 hover:text-whit'     
  end

  def nested_active(controller)       
    params[:controller] == controller ? 'active' : ''     
  end
end
