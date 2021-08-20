class WorkingDay < ApplicationRecord
  belongs_to :user

  # Checkin must be present in working day
  validates_presence_of :checkin, :user_id

  # TODO: Refactor lambda
  scope :user_filter, ->(user) { 
    if user.type == 'AdminUser'
      WorkingDay.all.newer_first
    else
      WorkingDay.where(user_id: user.id).newer_first
    end
  }

  # Sort items for working days from newest to oldest
  scope :newer_first, -> { order(created_at: :desc) }

  # Calculate worked minutes or hours for working_day
  def worked_time
    # If check out not nil calculate time else no time to calculate
    if !checkout.nil?
      time = ((checkout - checkin) / 1.hour).round
      if time >= 1
        time.to_s + ' hours.'
      else
        ((checkout - checkin) / 60).round.to_s + ' minutes.'
      end
    else
      '0 time.'
    end
  end

  # Method for report_kit 
  def self.worked_hours(properties)
    # [["Michael", "Anderson", "-01:00:00"], ["Michael", "Anderson", "-03:00:00"], ["Sofia", "Jackson", "-10:00:00"], ["Nicole", "Quinn", "-10:00:00"]]
    data = User.joins(:working_days).pluck(:name, :last_name, '((checkin - checkout) / 60 * 60)', :created_at)

    users = []

    data.each do |name, last_name, hours, creation|
      full_name = name + " " + last_name
      # gets negative format -06:00:00, so get chars at 1, 2 position
      hour = hours.byteslice(1, 2)
      u = [full_name, hour, creation]
      users << u
    end

    # [["Michael Anderson", "01"], ["Michael Anderson", "03"], ["Sofia Jackson", "10"]]
    # TODO: group data by matching names
    return users
  end
end
