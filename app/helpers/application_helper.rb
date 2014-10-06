module ApplicationHelper
  def active_if(controller)
    { class: controller_name.to_s == controller ? 'active' : 'inactive' }
  end
end
