require 'rails_helper'

RSpec.describe WorkingDay, type: :model do
  before do
    @user = User.create!(email: 'carlos@runarh.com', password: 'secret', password_confirmation: 'secret', name: 'Carlos', last_name: 'Gomez')
    @day = WorkingDay.create!(checkin: Time.now, checkout: Time.now + 1.hour, user_id: @user.id)
  end

  describe 'Working Day Creation' do
    it 'can be created' do
      expect(@day).to be_valid
    end

    it 'cannot be created without user_id' do
      @day.user_id = nil
      expect(@day).to_not be_valid
    end

    it 'checkin must not be empty' do
      @day.checkin = nil
      expect(@day).to_not be_valid
    end
  end
end