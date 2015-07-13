module ApplicationHelper
  def active_if(controller, action = nil)
    if (controller == controller_name) and (action.nil? or action == action_name)
      { class: 'active' }
    else
      { class: 'inactive' }
    end
  end
end
