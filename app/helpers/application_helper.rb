module ApplicationHelper
  # Implemented helper methods to ask if an user is an admin
  def admin_types
    ['AdminUser']
  end

  def employee?
    !admin?
  end

  def admin?
    admin_types.include?(current_user.type)
  end
end
