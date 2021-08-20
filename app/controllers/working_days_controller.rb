class WorkingDaysController < ApplicationController
  before_action :set_working_day, only: %i[show]

  def index
    @working_days = WorkingDay.user_filter(current_user)
  end

  def new
    @working_day = WorkingDay.new
  end

  def create
    @working_day = WorkingDay.new(working_day_params)
    @working_day.user_id = current_user.id

    if @working_day.save
      redirect_to working_days_path, notice: 'You make check! :)'
    else
      render :new
    end
  end

  def show; end

  private

  def working_day_params
    params.require(:working_day).permit(:checkin, :checkout)
  end

  def set_working_day
    @user_working_days = WorkingDay.where(user_id: params[:id])
    @user = User.find_by(id: params[:id])
  end
end
