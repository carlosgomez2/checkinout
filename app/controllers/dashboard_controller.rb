class DashboardController < ApplicationController
  def index
    @working_day = WorkingDay.new
  end

  def show
    @users = User.search(params[:search])
  end
end