module ApplicationHelper
  def is_active(path)       
    request.path == path ? 'bg-cyan-700 text-white' : 'text-gray-300 hover:bg-cyan-600 hover:text-white'     
  end

  def profile_nav_active(path)       
    request.path == path ? 'bg-cyan-200' : ''     
  end

  def nested_active(controller)       
    params[:controller] == controller ? 'bg-cyan-700' : ''     
  end
end
