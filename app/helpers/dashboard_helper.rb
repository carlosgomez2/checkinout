module DashboardHelper
  # Give format to user name
  def format_name
    current_user.name.capitalize
  end
end