module WorkingDaysHelper
  # Helper method to format Datetime data in working days view
  def check_format(datetime, type)
    if datetime.nil?
      # In case an employee has not checked out yet
      'No check out yet'
    elsif type == 'date'
      # For date | Month - Day - Year
      datetime.strftime('%B - %d - %y')
    elsif type == 'time'
      # For check | Hour : Minute, Meridian
      datetime.strftime('%H : %M, %p')
    end
  end
end
